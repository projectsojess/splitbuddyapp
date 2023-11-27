import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    userId: '',
    username: '',
    email: '',
    token: '',
    password: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
