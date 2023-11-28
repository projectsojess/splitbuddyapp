import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/group_data.dart';

class GroupItem extends StatelessWidget {
  final GroupData groupData;
  final VoidCallback onTap;

  const GroupItem({super.key, required this.groupData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color amountColor = groupData.amount >= 0 ? Colors.green : Colors.red;
    return ListTile(
      leading: Icon(groupData.icon),
      title: Text(groupData.name),
      subtitle: Text(
        groupData.amount >= 0
            ? 'You are owed \$${groupData.amount.abs()}'
            : 'You owe \$${groupData.amount.abs()}',
        style: TextStyle(color: amountColor),
      ),
      onTap: onTap, // Handle onTap event
    );
  }
}
