import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';
import 'package:splitbuddy/feature/friends/views/add_friends_screen.dart';
import 'package:splitbuddy/feature/friends/views/friend_detail_screen.dart';
import 'package:splitbuddy/providers/friends_provider.dart';
import 'package:splitbuddy/services/friends_service.dart';
import 'package:splitbuddy/themes/theme.dart';

class FriendsScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const FriendsScreen());

  const FriendsScreen({super.key});
  @override
  State<FriendsScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendsScreen> {
  FriendsService service = FriendsService();
  @override
  void initState() {
    super.initState();
    service.getFriends(context: context);
  }

  @override
  Widget build(BuildContext context) {
    var friendsProvider = Provider.of<FriendsProvider>(context);
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
      body: friendsProvider.friends.isEmpty
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
                      Navigator.push(
                        context,
                        AddFriendsScreen.route(),
                      );
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
              itemCount: friendsProvider.friends.length,
              itemBuilder: (context, index) {
                final FriendResponse friend = friendsProvider.friends[index];
                final String prefix =
                    friend.owed || friend.amount == 0 ? 'Owes ' : "You owe ";
                return ListTile(
                  leading: CircleAvatar(
                    // You can set profile images here
                    child: Text(friend.name[0]),
                  ),
                  title: Text(friend.name),
                  trailing: Text(
                    '${prefix}\$ ${friend.amount.toString()}',
                    style: TextStyle(
                      color: friend.owed || friend.amount == 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, FriendDetailScreen.route(friend: friend));
                  },
                );
              },
            ),
    );
  }
}
