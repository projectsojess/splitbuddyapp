import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/providers/user_provider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Text(user.email),
    );
  }
}
