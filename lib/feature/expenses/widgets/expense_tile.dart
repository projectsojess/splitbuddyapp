import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splitbuddy/common/functions.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/services/service.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseData expense;
  int userId = SharedPreferenceService.getInt("userId");

  ExpenseTile({required this.expense});

  @override
  Widget build(BuildContext context) {
    bool isUserPayer = expense.payer.payerId == userId;
    double amount = isUserPayer
        ? expense.payer.payedAmount - expense.payer.share
        : expense.payees
            .firstWhere(
              (payee) => payee.payeeId == userId,
            )
            .share;
    return Dismissible(
      key: Key(expense.expenseId.toString()), // Use a unique key for each tile
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        // Implement deletion logic here
        // You can use this function to remove the expense from the list
        // or perform any other delete operation.
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 29, 28, 28),
        ),
        child: ListTile(
            contentPadding: EdgeInsets.all(16.0),
            leading: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM')
                        .format(expense.date), // Display month name
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    DateFormat('d').format(expense.date), // Display day
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              expense.description,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paid by: ${expense.payer.payerId == userId ? 'You' : expense.payer.payerName}',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            trailing: Column(
              children: [
                Text(
                  isUserPayer ? 'You lent' : 'You borrowed',
                  style:
                      TextStyle(color: isUserPayer ? Colors.green : Colors.red),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  amount.toString(),
                  style: TextStyle(
                    color: isUserPayer ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
