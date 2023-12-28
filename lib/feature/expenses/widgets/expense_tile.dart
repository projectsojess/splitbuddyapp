import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/views/expense_detail_screen.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/services/expense_service.dart';
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
  ExpenseService service = ExpenseService();

  late Future<int> userIdFuture;

  void deleteExpense(int expenseId, int groupId) {
    service.deleteExpense(
      expenseId: expenseId,
      context: context,
      groupId: groupId,
    );
  }

  @override
  void initState() {
    super.initState();
    userIdFuture = getUserId();
  }

  Future<int> getUserId() async {
    int id = await SharedPreferenceService.getInt("userId");
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userIdFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching user ID'),
            );
          } else {
            final int userId =
                snapshot.data ?? 0; // Update userId with retrieved data
            return _buildUI(userId); // Return the UI after getting the user ID
          }
        } else {
          return Center(
            child: CircularProgressIndicator(), // Show a loading indicator
          );
        }
      },
    );
  }

  Widget _buildUI(int userId) {
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
    var provider = Provider.of<UserProvider>(context);
    print("user currency${provider.user.currency}");
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
        deleteExpense(widget.expense.expenseId, widget.groupData.groupId);
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
                          expenseId: widget.expense.expenseId,
                          groupData: widget.groupData,
                          userId: userId))
                  .then((value) {
                if (value != null && value == 'delete') {
                  print(value);
                  deleteExpense(
                      widget.expense.expenseId, widget.expense.expenseId);
                }
              });
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
