import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/user.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/feature/auth/views/login_view.dart';
import 'package:splitbuddy/feature/home/views/home_screen.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';

class AuthService {
  void SignUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    String? phone,
  }) async {
    try {
      User user = User(
          country: '',
          userId: 0,
          username: username,
          email: email,
          token: '',
          password: password,
          phone: phone,
          currency: '');

      http.Response res = await http.post(
        Uri.parse(ServerConstants.signupUrl),
        body: user.toJson(),
        headers: RequestHeaders.getUnAuthenticatedHeaders(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.push(
            context,
            LoginView.route(),
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response response = await http.post(
        Uri.parse(ServerConstants.signinUrl),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: RequestHeaders.getUnAuthenticatedHeaders(),
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            userProvider.setUser(response.body);
            await SharedPreferenceService.setString(
                RequestHeaders.JWT_HEADER, jsonDecode(response.body)['token']);
            await SharedPreferenceService.setInt(
                'userId', userProvider.user.userId);
            Navigator.push(context, HomeScreen.route());
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }
}
