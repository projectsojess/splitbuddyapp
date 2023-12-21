import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/views/expense_detail_screen.dart';
import 'package:splitbuddy/services/service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseTile extends StatefulWidget {
  final ExpenseData expense;
  final GroupData groupData;
  ExpenseTile({required this.expense, required this.groupData});

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  final int userId = SharedPreferenceService.getInt("userId");

  @override
  Widget build(BuildContext context) {
    bool isUserPayer = widget.expense.payer.payerId == userId;
    bool isUserPayee =
        widget.expense.payees.any((payee) => payee.payeeId == userId);
    double amount = isUserPayer
        ? widget.expense.payer.payedAmount - widget.expense.payer.share
        : isUserPayee
            ? widget.expense.payees
                .firstWhere(
                  (payee) => payee.payeeId == userId,
                )
                .share
            : 0;
    return Dismissible(
      key: Key(widget.expense.expenseId
          .toString()), // Use a unique key for each tile
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
            // color: Pallete.cardBgColor,
            ),
        child: ListTile(
            contentPadding: EdgeInsets.all(16.0),
            onTap: () {
              Navigator.push(
                  context,
                  ExpenseDetailScreen.route(
                      expenseData: widget.expense,
                      groupData: widget.groupData));
            },
            leading: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM')
                        .format(widget.expense.date), // Display month name
                    style: TextStyle(
                      color: Pallete.textColor,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    DateFormat('d').format(widget.expense.date), // Display day
                    style: TextStyle(
                      color: Pallete.textColor,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              widget.expense.description,
              style: TextStyle(
                color: Pallete.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paid by: ${widget.expense.payer.payerId == userId ? 'You' : widget.expense.payer.payerName}',
                  style: TextStyle(color: Pallete.textColor),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isUserPayer
                      ? 'You lent'
                      : isUserPayee
                          ? 'You borrowed'
                          : 'You\'re not involved',
                  style: TextStyle(
                      color: isUserPayer
                          ? Colors.green
                          : isUserPayee
                              ? Colors.red
                              : Colors.grey),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  amount.toString(),
                  style: TextStyle(
                    color: isUserPayer
                        ? Colors.green
                        : isUserPayee
                            ? Colors.red
                            : Colors.grey,
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
