import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/common/utils.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/feature/expenses/views/expense_detail_screen.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/themes/pallete.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(
        builder: (context, expenseProvider, child) => ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: expenseProvider.expenses.length,
                    itemBuilder: (context, index) {
                      return Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                          ExpenseData expense = expenseProvider.expenses[index];
                          bool isPayer =
                              expense.payer.payerId == userProvider.user.userId;
                          bool isPayee = expense.payees.any((payee) =>
                              payee.payeeId == userProvider.user.userId);
                          String prefix =
                              isPayer ? 'You' : expense.payer.payerName;
                          Color color = isPayer
                              ? Colors.green
                              : isPayee
                                  ? Colors.red
                                  : Colors.grey;
                          return Card(
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            child: ListTile(
                              onTap: () {
                                if (!isPayee && !isPayer) {
                                  showSnackbar(
                                      context, UIConstants.CANT_EDIT_EXPENSE);
                                } else {
                                  Navigator.push(
                                      context,
                                      ExpenseDetailScreen.route(
                                          expenseId: expense.expenseId,
                                          userId: userProvider.user.userId));
                                }
                              },
                              leading: CircleAvatar(
                                backgroundColor: color,
                                child: Icon(
                                  UIConstants.getCurrencyIcon(
                                      userProvider.user.currency),
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                '${prefix} paid ${UIConstants.getUnicode(userProvider.user.currency)}${expense.totalAmount} for ${expense.description}',
                                style: TextStyle(
                                  color: Pallete.textColor,
                                  fontSize: 15,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    isPayer ? "You'll get" : "You owe",
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    isPayer
                                        ? '${UIConstants.getUnicode(userProvider.user.currency)}${(expense.totalAmount - expense.payer.share).toStringAsFixed(2)}'
                                        : isPayee
                                            ? '${UIConstants.getUnicode(userProvider.user.currency)}${expense.payees.firstWhere((payee) => payee.payeeId == userProvider.user.userId).share.toStringAsFixed(2)}'
                                            : "0",
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ));
  }
}
