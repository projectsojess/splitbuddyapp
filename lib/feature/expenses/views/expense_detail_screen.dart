import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/bill_widget.dart';
import 'package:splitbuddy/feature/expenses/widgets/sharer_info_widget.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/services/service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseDetailScreen extends StatelessWidget {
  static route({required int expenseId, required GroupData groupData}) =>
      MaterialPageRoute(
          builder: (context) => ExpenseDetailScreen(
                expenseId: expenseId,
                groupData: groupData,
              ));
  final int expenseId;
  final GroupData groupData;
  const ExpenseDetailScreen(
      {super.key, required this.expenseId, required this.groupData});

  @override
  Widget build(BuildContext context) {
    final int userId = SharedPreferenceService.getInt("userId");
    return Consumer<ExpensesProvider>(
        builder: (context, expenseProvider, child) {
      var expenseData = expenseProvider.expenses
          .firstWhere((expense) => expense.expenseId == expenseId);
      bool isUserPaid = expenseData.payer.payerId == userId;
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemScreen(
                      users: groupData.members,
                      groupId: groupData.groupId,
                      fromScreen: 'GBAE',
                      items: expenseData.items!,
                      expenseData: expenseData,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Pallete.secondaryColor,
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
                        expenseData.description,
                        style: TextStyle(
                          fontSize: 20,
                          color: Pallete.textColor,
                        ),
                      ),
                      Text(
                        expenseData.totalAmount.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Paid by ${isUserPaid ? 'You' : expenseData.payer.payerName}',
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
                if (expenseData.items!.isNotEmpty) ...[
                  BillWidget(expense: expenseData, groupData: groupData),
                  SizedBox(
                    height: 20,
                  ),
                ],
                SharerInfoWidget(
                    expenseData: expenseData, isUserPayer: isUserPaid),
              ],
            ),
          ),
        ),
      );
    });
  }
}
