import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/feature/home/widgets/transactions_widget.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/providers/user_provider.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(
      builder: (context, expenseProvider, child) {
        List<ExpenseData> expenses = expenseProvider.expenses;

        return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            double amount =
                _calculateUserTotal(expenses, userProvider.user.userId);
            Color color = amount >= 0 ? Colors.green : Colors.red;
            String prefix = amount >= 0 ? "You'll get" : "You owe";
            amount = amount >= 0 ? amount : -1 * amount;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              prefix,
                              style: TextStyle(
                                color: color,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "${UIConstants.getUnicode(userProvider.user.currency)} ${amount.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            "Transactions",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TransactionWidget(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  double _calculateUserTotal(List<ExpenseData> expenses, int userId) {
    double amountOwed = 0;
    double amountLent = 0;

    expenses.forEach((expense) {
      if (expense.payer.payerId == userId) {
        amountLent += expense.totalAmount - expense.payer.share;
      } else if (expense.payees.any((payee) => payee.payeeId == userId)) {
        amountOwed +=
            expense.payees.firstWhere((payee) => payee.payeeId == userId).share;
      }
    });
    return amountLent - amountOwed;
  }
}
