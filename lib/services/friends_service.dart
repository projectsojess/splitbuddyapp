import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/providers/friends_provider.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';

class FriendsService {
  void addFriend({required context, String? email, String? phone}) async {
    try {
      var friendsProvider =
          Provider.of<FriendsProvider>(context, listen: false);
      String token =
          await SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
      http.Response response = await http.post(
        Uri.parse(ServerConstants.addFriendUrl),
        body: jsonEncode({"email": email, "phone": phone}),
        headers: RequestHeaders.getAuthenticatedHeaders(token: token),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            friendsProvider.addFriend(response.body);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void getFriends({required context}) async {
    try {
      var friendsProvider =
          Provider.of<FriendsProvider>(context, listen: false);
      String token =
          await SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
      http.Response response = await http.get(
        Uri.parse(ServerConstants.getFriendsUrl),
        headers: RequestHeaders.getAuthenticatedHeaders(token: token),
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            friendsProvider.addAllFriends(response.body);
          });
    } catch (e) {
      print(e);
      throw Exception('Failed to load data');
    }
  }
}
