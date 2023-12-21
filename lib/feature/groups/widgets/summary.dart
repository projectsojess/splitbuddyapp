import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/themes/pallete.dart';

class Summary extends StatelessWidget {
  final int userId;
  final List<ExpenseData> expenses;
  const Summary({super.key, required this.expenses, required this.userId});

  @override
  Widget build(BuildContext context) {
    double totalGroupspents = 0;
    double userSpent = 0;
    double userOwe = 0;
    expenses.forEach((expense) {
      totalGroupspents += expense.totalAmount;
      if (expense.payer.payerId == userId) {
        userSpent += expense.payer.payedAmount;
        userOwe += expense.payer.share;
      } else if (expense.payees.any((payee) => payee.payeeId == userId)) {
        userOwe +=
            expense.payees.firstWhere((payee) => payee.payeeId == userId).share;
      }
    });
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 20,
                  color: Pallete.textColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total group spents ',
                style: TextStyle(
                  fontSize: 15,
                  color: Pallete.textColor,
                ),
              ),
              Text(
                totalGroupspents.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your total spents',
                style: TextStyle(
                  fontSize: 15,
                  color: Pallete.textColor,
                ),
              ),
              Text(
                userSpent.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your share',
                style: TextStyle(
                  color: Pallete.textColor,
                  fontSize: 15,
                ),
              ),
              Text(
                userOwe.toString(),
                style: TextStyle(color: Colors.red, fontSize: 15),
              )
            ],
          )
        ],
      ),
    );
  }
}
