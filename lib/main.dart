import 'package:flutter/material.dart';
import 'package:splitbuddy/common/welcome_page.dart';
import 'package:splitbuddy/feature/auth/views/login_view.dart';
import 'package:splitbuddy/feature/auth/views/verify_otp_screen.dart';
import 'package:splitbuddy/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: const WelcomePage(),
    );
  }
}
