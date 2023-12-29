import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/dtos.dart';
import 'package:splitbuddy/providers/user_provider.dart';

class GroupItem extends StatelessWidget {
  final GroupData groupData;
  final VoidCallback onTap;

  const GroupItem({super.key, required this.groupData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double amountBorrowed = groupData.amountBorrowed;
    double amountLent = groupData.amountLent;
    bool isDebt = amountBorrowed > amountLent;
    double debt =
        isDebt ? amountBorrowed - amountLent : amountLent - amountBorrowed;
    Color color = isDebt ? Colors.red : Colors.green;
    String prefix = isDebt ? "You owe" : "Owes you";
    return ListTile(
      leading: CircleAvatar(
        child: Text(groupData.groupName[0]),
      ),
      title: Text(
        groupData.groupName,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            prefix,
            style: TextStyle(
              color: color,
              fontSize: 11,
            ),
          ),
          Consumer<UserProvider>(
            builder: (context, userProvider, child) => Text(
              '${UIConstants.getUnicode(userProvider.user.currency)} ${debt.toStringAsFixed(2)}',
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
