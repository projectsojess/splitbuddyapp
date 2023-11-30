import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';
import 'package:splitbuddy/feature/friends/views/add_friends_screen.dart';
import 'package:splitbuddy/feature/friends/views/friend_screen.dart';
import 'package:splitbuddy/providers/friends_provider.dart';
import 'package:splitbuddy/themes/theme.dart';

class FriendsScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const FriendsScreen());

  const FriendsScreen({super.key});
  @override
  State<FriendsScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    final List<FriendResponse> friendsList =
        Provider.of<FriendsProvider>(context).friends;
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            color: Pallete.secondaryColor,
            onPressed: () {
              Navigator.push(context, AddFriendsScreen.route());
            },
          ),
        ],
      ),
      body: friendsList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No friends added yet.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, AddFriendsScreen.route());
                    },
                    label: Text('Add Friends'),
                    icon: Icon(Icons.person_add),
                    style: ElevatedButton.styleFrom(
                        primary: Pallete.secondaryColor),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    // You can set profile images here
                    child: Text(friendsList[index].name[0]),
                  ),
                  title: Text(friendsList[index].name),
                  trailing: Text(
                    '\$${friendsList[index].amount.toString()}',
                  ),
                  onTap: () {
                    Navigator.push(context, FriendScreen.route(1000));
                  },
                );
              },
            ),
    );
  }
}
