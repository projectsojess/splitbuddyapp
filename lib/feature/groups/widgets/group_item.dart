import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/dtos.dart';

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
    String prefix = isDebt ? "You owe" : "You lent";
    return ListTile(
      leading: CircleAvatar(
        child: Text(groupData.groupName[0]),
      ),
      title: Text(groupData.groupName),
      trailing: Text(
        '${prefix}\$ ${debt}',
        style: TextStyle(color: color),
      ),
      onTap: onTap,
    );
  }
}
