import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:splitbuddy/dtos/login_response.dart';

class UserProvider extends ChangeNotifier {
  Box<LoginResponse> _userBox = Hive.box<LoginResponse>('user');

  void init() {
    _userBox.watch().listen((event) {
      notifyListeners();
    });
  }

  LoginResponse get user => _userBox.values.toList()[0];

  void setUser(String user) {
    LoginResponse userRes = LoginResponse.fromJson(jsonDecode(user));
    _userBox.put(userRes.userId, userRes);
    notifyListeners();
  }

  void removeUser(int userId) {
    _userBox.delete(userId);
    notifyListeners();
  }
}
