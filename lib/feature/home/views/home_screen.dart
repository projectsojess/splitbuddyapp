import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(user.email)],
      ),
    );
  }
}
