import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/groups/widgets/group_item.dart';

List<GroupData> groups = [];

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Groups',
        ),
      ),
      body: groups.isEmpty
          ? Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle the button press to create a group
                  // You can navigate to a create group screen or perform any other action here
                },
                icon: Icon(Icons.add),
                label: Text('Create a Group'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
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
