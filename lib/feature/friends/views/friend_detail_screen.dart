import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/create_expense_response.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';
import 'package:splitbuddy/feature/expenses/views/create_expense.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
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
  List<CreateExpenseResponse> expenses = [];
  @override
  Widget build(BuildContext context) {
    final List<FriendResponse> friends = [widget.friend];
    List<CreateExpenseResponse> expenses =
        Provider.of<ExpensesProvider>(context).expenses;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend.name),
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
                return Dismissible(
                  key: Key(expense.description), // Unique key for each item
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
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(formattedDate),
                        Icon(Icons.food_bank),
                      ],
                    ),
                    title: Text(expense.description),
                    trailing: Text(
                      '\$${expense.totalAmount}',
                      style: TextStyle(
                        color: expense.totalAmount! < 0.0
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
