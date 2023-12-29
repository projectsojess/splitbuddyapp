import 'package:flutter/material.dart';
import 'package:splitbuddy/feature/home/views/home_screen.dart';
import 'package:splitbuddy/feature/welcome_page.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    bool isLoggedIn = await SharedPreferenceService.getBool('isLoggedIn');
    int userId = await SharedPreferenceService.getInt("userId");
    print("userid${userId}");
    // Navigate based on login status
    if (isLoggedIn) {
      // If logged in, navigate to home screen
      Navigator.of(context).pushReplacement(HomeScreen.route());
    } else {
      // If not logged in, navigate to login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Placeholder for a splash screen UI
      ),
    );
  }
}
