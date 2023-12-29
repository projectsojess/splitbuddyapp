import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/feature/groups/views/create_group_screen.dart';
import 'package:splitbuddy/feature/groups/views/group_detail_screen.dart';
import 'package:splitbuddy/feature/groups/widgets/group_item.dart';
import 'package:splitbuddy/providers/group_provider.dart';
import 'package:splitbuddy/services/expense_service.dart';
import 'package:splitbuddy/services/group_service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  GroupService groupService = GroupService();
  ExpenseService expenseService = ExpenseService();

  @override
  void initState() {
    super.initState();
    groupService.getAllGroups(context: context);
  }

  @override
  Widget build(BuildContext context) {
    List<GroupData> groups = Provider.of<GroupProvider>(context).groups;
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
                  Navigator.push(context, CreateGroupScreen.route(type: "N"));
                },
                icon: Icon(Icons.add),
                label: Text('Create a Group'),
                style: ElevatedButton.styleFrom(
                  primary: Pallete.secondaryColor,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupDetailScreen(
                          groupId: groups[index].groupId,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
