import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/groups/widgets/group_item.dart';

List<GroupData> groups = [
  GroupData(name: 'Group 1', icon: Icons.group, amount: 50.0, groupId: 1000),
  GroupData(name: 'Group 2', icon: Icons.group, amount: -30.0, groupId: 1001),
  GroupData(name: 'Group 3', icon: Icons.group, amount: 20.0, groupId: 1002),
  GroupData(name: 'Group 4', icon: Icons.group, amount: -10.0, groupId: 1003),
];

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: groups.isEmpty
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle the button press to create a group
                  // You can navigate to a create group screen or perform any other action here
                },
                child: Text('Create a Group'),
              ),
            )
          : ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return GroupItem(
                  groupData: groups[index],
                  onTap: () {
                    // Navigate to the next screen when a group is tapped
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => GroupDetailScreen(groups[index].groupId),
                    //   ),
                    // );
                  },
                );
              },
            ),
    );
  }
}
