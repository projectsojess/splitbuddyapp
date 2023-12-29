import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/dtos/items.dart';
import 'package:splitbuddy/providers/group_provider.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseItemsList extends StatefulWidget {
  final List<Item> items;
  final int groupId;
  const ExpenseItemsList(
      {super.key, required this.items, required this.groupId});

  @override
  State<ExpenseItemsList> createState() => _ExpenseItemsListState();
}

class _ExpenseItemsListState extends State<ExpenseItemsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groupProvider, child) {
        GroupData groupData = groupProvider.groups
            .firstWhere((group) => group.groupId == widget.groupId);
        return Consumer<UserProvider>(
          builder: (context, userProvider, child) => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                Item item = widget.items[index];
                String itemSharers = '';
                item.usersInvolved!.forEach((user) => itemSharers +=
                    (user == userProvider.user.userId
                            ? 'You'
                            : groupData.members[user]!) +
                        (item.usersInvolved!.last == user ? '' : ','));
                return ListTile(
                  leading: Text(
                    'x${item.quantity.toString()}',
                    style: TextStyle(
                      color: Pallete.textColor,
                      fontSize: 20,
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: TextStyle(
                      color: Pallete.textColor,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Text(
                    item.amount.toStringAsFixed(2),
                    style: TextStyle(
                      color: Pallete.textColor,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Text(
                    'sharers: ${itemSharers}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
