import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/login_response.dart';

class UserProvider extends ChangeNotifier {
  LoginResponse _user = LoginResponse(
      userId: 0,
      username: '',
      email: '',
      token: '',
      country: '',
      currency: '',
      displayCurrency: '');

  LoginResponse get user => _user;

  void setUser(String user) {
    _user = LoginResponse.fromJson(jsonDecode(user));
    notifyListeners();
  }

  void setUserFromModel(LoginResponse user) {
    _user = user;
    notifyListeners();
  }
}
