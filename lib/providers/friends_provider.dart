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
      friendsResponse.forEach((response) {
        bool found =
            _friends.any((e) => e.userToFriendId == response.userToFriendId);

        if (found) {
          _friends.forEach((friend) {
            if ((friend.userToFriendId == response.userToFriendId) &&
                (friend.amount != response.amount)) {
              friend.amount = response.amount;
              friend.owed = response.owed;
              notifyListeners();
            }
          });
        } else {
          _friends.add(response);
          notifyListeners();
        }
      });
    } else {
      _friends.addAll(friendsResponse);
      notifyListeners();
    }
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
