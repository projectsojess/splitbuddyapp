import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/friendResponse.dart';

class FriendsProvider extends ChangeNotifier {
  List<FriendResponse> _friends = [];

  List<FriendResponse> get friends => _friends;

  void addFriend(String friend) {
    _friends.add(FriendResponse.fromJson(friend));
    notifyListeners();
  }

  void addAllFriends(String jsonString) {
    List<FriendResponse> friendsResponse =
        FriendResponse.friendResponseListFromJson(jsonString);
    if (_friends.isNotEmpty) {
      if (friendsResponse.isNotEmpty) {
        friendsResponse.forEach((res) {
          bool found = _friends
              .any((element) => element.userToFriendId == res.userToFriendId);

          if (found) {
            FriendResponse friend = _friends.firstWhere(
                (element) => element.userToFriendId == res.userToFriendId);

            if (friend.amount != res.amount) {
              friend.owed = res.owed;
              friend.amount = res.amount;
            }
          } else {
            _friends.add(res);
          }
        });
      }
    } else {
      _friends.addAll(friendsResponse);
    }
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
