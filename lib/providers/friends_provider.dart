import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';

class FriendsProvider extends ChangeNotifier {
  List<FriendResponse> _friends = [];

  List<FriendResponse> get friends => _friends;

  void addFriend(String friend) {
    friends.add(FriendResponse.fromJson(friend));
    notifyListeners();
  }

  void addAllFriends(String jsonString) {
    friends.addAll(FriendResponse.friendResponseListFromJson(jsonString));
    notifyListeners();
  }

  void addAllFriendsFromModel(List<FriendResponse> friends) {
    this.friends.addAll(friends);
    notifyListeners();
  }

  void addFriendModel(FriendResponse friend) {
    friends.add(friend);
    notifyListeners();
  }

  void removeFriend(int id) {
    for (int i = 0; i < friends.length; i++) {
      if (friends[i].userToFriendId == id) {
        friends.removeAt(i);
        notifyListeners();
        break;
      }
    }
  }
}
