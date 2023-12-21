import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/bill_widget.dart';
import 'package:splitbuddy/feature/expenses/widgets/sharer_info_widget.dart';
import 'package:splitbuddy/services/expense_service.dart';
import 'package:splitbuddy/services/service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseDetailScreen extends StatefulWidget {
  static route(
          {required ExpenseData expenseData, required GroupData groupData}) =>
      MaterialPageRoute(
          builder: (context) => ExpenseDetailScreen(
                expenseData: expenseData,
                groupData: groupData,
              ));

  final ExpenseData expenseData;
  final GroupData groupData;
  const ExpenseDetailScreen(
      {super.key, required this.expenseData, required this.groupData});

  @override
  State<ExpenseDetailScreen> createState() => _ExpenseDetailScreenState();
}

class _ExpenseDetailScreenState extends State<ExpenseDetailScreen> {
  ExpenseService service = ExpenseService();
  final int userId = SharedPreferenceService.getInt("userId");
  void deleteExpense(int expenseId, int groupId) {
    service.deleteExpense(
        expenseId: expenseId,
        context: context,
        groupId: groupId,
        popBack: true);
  }

  @override
  Widget build(BuildContext context) {
    bool isUserPaid = widget.expenseData.payer.payerId == userId;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (widget.expenseData.type == 'GBA') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemScreen(
                      users: widget.groupData.members,
                      groupId: widget.groupData.groupId,
                      fromScreen: 'GBAE',
                      items: widget.expenseData.items!,
                      expenseData: widget.expenseData,
                    ),
                  ),
                );
              }
            },
            icon: Icon(
              Icons.edit,
              color: Pallete.secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              deleteExpense(
                  widget.expenseData.expenseId, widget.groupData.groupId);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
        title: Text('Expense Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      widget.expenseData.description,
                      style: TextStyle(
                        fontSize: 20,
                        color: Pallete.textColor,
                      ),
                    ),
                    Text(
                      widget.expenseData.totalAmount.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Paid by ${isUserPaid ? 'You' : widget.expenseData.payer.payerName}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Pallete.textColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              if (widget.expenseData.items!.isNotEmpty) ...[
                BillWidget(
                    expense: widget.expenseData, groupData: widget.groupData),
                SizedBox(
                  height: 20,
                ),
              ],
              SharerInfoWidget(
                  expenseData: widget.expenseData, isUserPayer: isUserPaid),
            ],
          ),
        ),
      ),
    );
  }
}
