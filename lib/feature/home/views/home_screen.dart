import 'package:flutter/material.dart';
import 'package:splitbuddy/feature/widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppNavigationBar(),
    );
  }
}
