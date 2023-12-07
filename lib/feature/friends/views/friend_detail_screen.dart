import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/create_expense_response.dart';
import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';
import 'package:splitbuddy/feature/expenses/views/create_expense.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/expense_tile.dart';
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

  @override
  void initState() {
    super.initState();
    service.getAllExpenses(context: context);
    int userId = SharedPreferenceService.getInt("userId");
    users = {
      userId: 'You',
      widget.friend.friendId: widget.friend.name,
    };
  }

  @override
  Widget build(BuildContext context) {
    final List<FriendResponse> friends = [widget.friend];
    List<CreateExpenseResponse> expenses =
        Provider.of<ExpensesProvider>(context)
            .expensesFriends
            .where((element) =>
                element.userToFriendId == widget.friend.userToFriendId)
            .toList();
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
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                CreateExpenseResponse expense = expenses[index];
                String formattedDate =
                    '${expense.date.month}/${expense.date.day}';
                ExpensePayer payer = expense.payer;
                List<ExpensePayee> payee = expense.payees;
                bool isFriendPayer = payer.payerId == widget.friend.friendId;
                Color color = isFriendPayer ? Colors.red : Colors.green;
                String prefix = isFriendPayer ? "You owes " : "Owes ";
                return Dismissible(
                  key: Key(
                      expense.expenseId.toString()), // Unique key for each item
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      expenses.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('${expense.description} dismissed')),
                    );
                  },
                  child: ExpenseTile(
                    color: color,
                    expense: expense,
                    payer: payer,
                    payee: payee,
                    isFriendPayer: isFriendPayer,
                  ),
                );
              },
            ),
    );
  }
}
