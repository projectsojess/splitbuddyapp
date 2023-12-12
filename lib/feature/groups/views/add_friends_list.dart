import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/providers/friends_provider.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AddFriendsList extends StatefulWidget {
  const AddFriendsList({
    super.key,
  });

  static route() => MaterialPageRoute(builder: (context) => AddFriendsList());
  @override
  State<AddFriendsList> createState() => _AddFriendsListState();
}

class _AddFriendsListState extends State<AddFriendsList> {
  Map<int, String> selectedUsers = {};
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
            value: selectedUsers.containsKey(friends[index].friendId),
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  selectedUsers[friends[index].friendId] = friends[index].name;
                } else {
                  selectedUsers.remove(friends[index].friendId);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Here, you can handle adding selectedFriends to the group
          // For example:
          // print('Selected Friends: $selectedFriends');
          Navigator.pop(
              context, selectedUsers); // Go back to the previous screen
        },
        backgroundColor: Pallete.secondaryColor,
        child: Icon(Icons.done),
      ),
    );
  }
}
