import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/expenses.dart';
import 'package:splitbuddy/feature/expenses/views/create_expense.dart';
import 'package:splitbuddy/themes/pallete.dart';

class FriendScreen extends StatefulWidget {
  final int friendId;
  static route(friendId) =>
      MaterialPageRoute(builder: (context) => FriendScreen(friendId: friendId));
  const FriendScreen({super.key, required this.friendId});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  List<Expense> expenses = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: expenses.isEmpty
          ? Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, CreateExpenseNormal.route());
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
                Expense expense = expenses[index];
                String formattedDate =
                    '${expense.date.month}/${expense.date.day}';
                return Dismissible(
                  key: Key(expense.name), // Unique key for each item
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
                      SnackBar(content: Text('${expense.name} dismissed')),
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
                    title: Text(expense.name),
                    trailing: Text(
                      '\$${expense.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: expense.isOwed ? Colors.red : Colors.green,
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
