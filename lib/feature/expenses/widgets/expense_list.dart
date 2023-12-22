import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_tile.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseList extends StatelessWidget {
  final GroupData groupData;

  const ExpenseList({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(
      builder: (context, expensesProvider, child) => expensesProvider.expenses
              .where((expense) => expense.groupId == groupData.groupId)
              .isEmpty
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
                            users: groupData.members,
                            groupId: groupData.groupId,
                            fromScreen: 'GBA',
                            items: [],
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
                    itemCount: expensesProvider.expenses
                        .where(
                            (expense) => expense.groupId == groupData.groupId)
                        .length,
                    itemBuilder: (context, index) {
                      var expenses = expensesProvider.expenses
                          .where(
                              (expense) => expense.groupId == groupData.groupId)
                          .toList();
                      ExpenseData expense = expenses[index];
                      // Replace with your transaction item UI
                      return ExpenseTile(
                        expense: expense,
                        groupData: groupData,
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}
