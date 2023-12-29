import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/friend_response.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/expenses/widgets/add_items.dart';
import 'package:splitbuddy/feature/expenses/widgets/bill_widget.dart';
import 'package:splitbuddy/feature/expenses/widgets/sharer_info_widget.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/providers/friends_provider.dart';
import 'package:splitbuddy/providers/group_provider.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseDetailScreen extends StatelessWidget {
  static route({required int expenseId, required userId}) => MaterialPageRoute(
      builder: (context) => ExpenseDetailScreen(
            expenseId: expenseId,
            userId: userId,
          ));
  final int expenseId;
  final int userId;
  const ExpenseDetailScreen({
    super.key,
    required this.expenseId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(
        builder: (context, expenseProvider, child) {
      var expenseData = expenseProvider.expenses
          .firstWhere((expense) => expense.expenseId == expenseId);
      bool isUserPaid = expenseData.payer.payerId == userId;
      return Scaffold(
        appBar: AppBar(
          actions: [
            if (expenseData.groupId != 0) ...[
              Consumer<GroupProvider>(
                builder: (context, groupProvider, child) {
                  GroupData groupData = groupProvider.groups.firstWhere(
                    (group) => group.groupId == expenseData.groupId,
                  );
                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItemScreen(
                            users: groupData.members,
                            groupId: groupData.groupId,
                            fromScreen: 'GBAE',
                            items: expenseData.items!,
                            expenseData: expenseData,
                            userId: userId,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Pallete.secondaryColor,
                    ),
                  );
                },
              )
            ],
            if (expenseData.userToFriendId != 0) ...[
              Consumer<FriendsProvider>(
                builder: (context, friendsProvider, child) {
                  FriendResponse friend = friendsProvider.friends.firstWhere(
                    (friend) =>
                        friend.userToFriendId == expenseData.userToFriendId,
                  );
                  Map<int, String> users = {
                    userId: "You",
                    friend.friendId: friend.name
                  };
                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItemScreen(
                            users: users,
                            userToFriendId: expenseData.userToFriendId,
                            fromScreen: 'FBAE',
                            items: expenseData.items!,
                            expenseData: expenseData,
                            userId: userId,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Pallete.secondaryColor,
                    ),
                  );
                },
              )
            ]
          ],
          title: Text('Expense Details'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        expenseData.description,
                        style: TextStyle(
                          fontSize: 20,
                          color: Pallete.textColor,
                        ),
                      ),
                      Text(
                        expenseData.totalAmount.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Paid by ${isUserPaid ? 'You' : expenseData.payer.payerName}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Pallete.textColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                if (expenseData.items!.isNotEmpty) ...[
                  BillWidget(
                    expense: expenseData,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
                SharerInfoWidget(
                    expenseData: expenseData, isUserPayer: isUserPaid),
              ],
            ),
          ),
        ),
      );
    });
  }
}
