import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';
import 'package:splitbuddy/feature/expenses/views/create_expense.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/services/expense_service.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class FriendDetailScreen extends StatefulWidget {
  final FriendResponse friend;
  static route({required FriendResponse friend}) => MaterialPageRoute(
      builder: (context) => FriendDetailScreen(friend: friend));
  const FriendDetailScreen({Key? key, required this.friend}) : super(key: key);

  @override
  State<FriendDetailScreen> createState() => _FriendDetailScreenState();
}

class _FriendDetailScreenState extends State<FriendDetailScreen> {
  Map<int, String> users = {};
  ExpenseService service = ExpenseService();
  int userId = SharedPreferenceService.getInt("userId");

  @override
  void initState() {
    super.initState();
    service.getAllExpenses(context: context);
    users = {
      userId: 'You',
      widget.friend.friendId: widget.friend.name,
    };
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.friend.owed ? 'Owes' : 'You owes';
    Color colorOwe = widget.friend.owed ? Colors.green : Colors.red;
    final List<FriendResponse> friends = [widget.friend];
    List<ExpenseData> expenses = Provider.of<ExpensesProvider>(context)
        .expenses
        .where(
            (element) => element.userToFriendId == widget.friend.userToFriendId)
        .toList();
    int cardTranLen = expenses.length > 3 ? 3 : expenses.length;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.friend.name),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(
                Icons.add, // Plus icon
                color: Pallete.secondaryColor, // Set the color to orange
              ),
              onSelected: (value) {
                switch (value) {
                  case 'addExpense':
                    Navigator.push(
                      context,
                      CreateExpenseNormal.route(friend: friends),
                    );
                    break;
                  case 'advancedExpense':
                    // Navigate to the advanced expense screen
                    // Replace 'YourAdvancedExpenseScreen' with the actual screen you want to navigate to
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddItemScreen(
                                users: users,
                                userToFriendId: friends[0].userToFriendId,
                                fromScreen: 'FBA',
                              )),
                    );
                    break;
                  // Add mor
                  // Add more cases for other actions/screens
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'addExpense',
                  child: Text('Add Expense'),
                ),
                const PopupMenuItem<String>(
                  value: 'advancedExpense',
                  child: Text('Advanced Expense'),
                ),
                // Add more PopupMenuItems for other actions
              ],
            ),
          ],
        ),
        body: expenses.isEmpty
            ? Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context, CreateExpenseNormal.route(friend: friends));
                  },
                  icon: Icon(Icons.plus_one),
                  style:
                      ElevatedButton.styleFrom(primary: Pallete.secondaryColor),
                  label: Text('Add Expense'),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                          color: colorOwe,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.friend.amount.toString(),
                                        style: TextStyle(
                                          color: colorOwe,
                                          fontSize: 25,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  for (int i = 0; i < cardTranLen; i++)
                                    Row(
                                      children: [
                                        Text(
                                          expenses[i].payer.payerId == userId
                                              ? 'You lent ' +
                                                  widget.friend.name +
                                                  ' ' +
                                                  expenses[i]
                                                      .payees[0]
                                                      .share
                                                      .toString()
                                              : 'You borrowed ' +
                                                  expenses[i]
                                                      .payees[0]
                                                      .share
                                                      .toString(),
                                          style: TextStyle(
                                            color: expenses[i].payer.payerId ==
                                                    userId
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                ],
                              ))),
                      Card(
                        elevation: 0, // No elevation to blend with the screen
                        margin: EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Transactions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            // Add your list of transactions here
                            // Example: ListView.builder for transaction items
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: expenses.length,
                              itemBuilder: (context, index) {
                                ExpenseData expense = expenses[index];
                                String formattedDate =
                                    '${expense.date.month}/${expense.date.day}';
                                ExpensePayer payer = expense.payer;
                                List<ExpensePayee> payee = expense.payees;
                                bool isFriendPayer =
                                    payer.payerId == widget.friend.friendId;
                                Color color =
                                    isFriendPayer ? Colors.red : Colors.green;
                                String prefix = isFriendPayer
                                    ? "You borrowed "
                                    : "You lent ";
                                // Replace with your transaction item UI
                                return ListTile(
                                  leading: Icon(Icons.food_bank),
                                  iconColor: Pallete.secondaryColor,
                                  title: Text(expenses[index].description),
                                  subtitle: Text(
                                    'Paid by: ${payer.payerName}',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          prefix,
                                          style: TextStyle(
                                            color: color,
                                          ),
                                        ),
                                        Text(
                                          payee[0].share.toString(),
                                          style: TextStyle(
                                            color: color,
                                          ),
                                        )
                                      ]),
                                  // Add more details as needed for each transaction
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
