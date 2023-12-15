import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/providers/friends_provider.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AddFriendsList extends StatefulWidget {
  final Map<int, String> selectedUsers;
  const AddFriendsList({super.key, required this.selectedUsers});

  static route({required Map<int, String> selectedUsers}) => MaterialPageRoute(
      builder: (context) => AddFriendsList(
            selectedUsers: selectedUsers,
          ));
  @override
  State<AddFriendsList> createState() => _AddFriendsListState();
}

class _AddFriendsListState extends State<AddFriendsList> {
  @override
  Widget build(BuildContext context) {
    var friends = Provider.of<FriendsProvider>(context).friends;
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List'),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            title: Text(friends[index].name),
            value: widget.selectedUsers.containsKey(friends[index].friendId),
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  widget.selectedUsers[friends[index].friendId] =
                      friends[index].name;
                } else {
                  widget.selectedUsers.remove(friends[index].friendId);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(
              context, widget.selectedUsers); // Go back to the previous screen
        },
        backgroundColor: Pallete.secondaryColor,
        child: Icon(Icons.done),
      ),
    );
  }
}
