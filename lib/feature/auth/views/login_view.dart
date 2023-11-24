import "package:flutter/material.dart";
import "package:splitbuddy/feature/auth/widgets/auth_field.dart";
import "package:splitbuddy/themes/pallete.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Pallete.inputLabelTextColor,
                    ),
                  )),
              AuthField(
                controller: emailController,
                hintText: 'Enter your email',
              ),
              Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Pallete.inputLabelTextColor,
                    ),
                  )),
              AuthField(
                controller: passwordController,
                hintText: 'Enter your password',
              )
            ],
          ),
        )),
      ),
    );
  }
}
