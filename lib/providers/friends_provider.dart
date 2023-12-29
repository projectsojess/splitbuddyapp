import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:splitbuddy/dtos/friend_response.dart';

class FriendsProvider extends ChangeNotifier {
  Box<FriendResponse> _friendsBox = Hive.box<FriendResponse>('friends');

  List<FriendResponse> get friends => _friendsBox.values.toList();
  void init() {
    _friendsBox.watch().listen((event) {
      notifyListeners();
    });
  }

  void addFriend(String friend) {
    FriendResponse friendResponse = FriendResponse.fromJson(jsonDecode(friend));
    _friendsBox.put(friendResponse.userToFriendId, friendResponse);
    notifyListeners();
  }

  void addAllFriends(String jsonString) {
    List<FriendResponse> friendResponse = List<FriendResponse>.from(
        jsonDecode(jsonString)['friends']
            .map((model) => FriendResponse.fromJson(model)));
    friendResponse
        .forEach((friend) => _friendsBox.put(friend.userToFriendId, friend));
  }
}
