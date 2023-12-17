import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_tile.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseData> expenses;
  final GroupData groupData;

  const ExpenseList(
      {super.key, required this.expenses, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? Container(
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 29, 28, 28),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddItemScreen(
                                users: groupData.members,
                                groupId: groupData.groupId,
                                fromScreen: 'GBA',
                              )),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style:
                      ElevatedButton.styleFrom(primary: Pallete.secondaryColor),
                  label: Text(
                    'Add Expense',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 29, 28, 28),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  ExpenseData expense = expenses[index];
                  // Replace with your transaction item UI
                  return ExpenseTile(expense: expense);
                },
              ),
            ),
          );
  }
}
