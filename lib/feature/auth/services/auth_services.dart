import 'package:flutter/material.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/user.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/feature/auth/views/login_view.dart';

class AuthService {
  static void SignUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    String? phone,
  }) async {
    try {
      User user = User(
          userId: '',
          username: username,
          email: email,
          token: '',
          password: password,
          phone: phone);

      http.Response res = await http.post(
        Uri.parse('${ServerConstants.serverUrl}${ServerConstants.signupUrl}'),
        body: user.toJson(),
        headers: RequestHeaders.getUnAuthenticatedHeaders(),
      );

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
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }
}
