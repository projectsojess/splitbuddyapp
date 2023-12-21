import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_tile.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseList extends StatefulWidget {
  final List<ExpenseData> expenses;
  final GroupData groupData;

  const ExpenseList(
      {super.key, required this.expenses, required this.groupData});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return widget.expenses.isEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    // color: Pallete.cardBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'No expenses yet.',
                      style: TextStyle(color: Pallete.textColor),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddItemScreen(
                          users: widget.groupData.members,
                          groupId: widget.groupData.groupId,
                          fromScreen: 'GBA',
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Pallete.secondaryColor,
                  ),
                  label: Text(
                    'Add Expense',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Expanded(
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.expenses.length,
                  itemBuilder: (context, index) {
                    ExpenseData expense = widget.expenses[index];
                    // Replace with your transaction item UI
                    return ExpenseTile(
                      expense: expense,
                      groupData: widget.groupData,
                    );
                  },
                )
              ],
            ),
          );
  }
}
