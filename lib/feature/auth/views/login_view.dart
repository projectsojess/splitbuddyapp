import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:splitbuddy/constants/constants.dart";
import "package:splitbuddy/feature/auth/views/signup_screen.dart";
import "package:splitbuddy/feature/auth/widgets/auth_field.dart";
import "package:splitbuddy/services/auth_services.dart";
import "package:splitbuddy/themes/pallete.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final String iconPathEmail = AssetConstants.envelope;
  final String iconPathPassword = AssetConstants.lock;

  final AuthService service = AuthService();

  void loginUser() {
    service.signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

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
                  alignment: Alignment.center,
                  child: Column(children: [
                    Image.asset(
                      AssetConstants.loginScreenimage,
                      height: 300,
                    ),
                    Text(
                      'SplitBuddy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Source Sans Pro',
                      ),
                    ),
                  ])),
              Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Pallete.inputLabelTextColor,
                      fontSize: 16,
                    ),
                  )),
              AuthField(
                obscureText: false,
                controller: emailController,
                hintText: 'Enter your email',
                iconPath: iconPathEmail,
              ),
              Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Pallete.inputLabelTextColor,
                      fontSize: 16,
                    ),
                  )),
              AuthField(
                obscureText: true,
                controller: passwordController,
                hintText: 'Enter your password',
                iconPath: iconPathPassword,
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password action
                  },
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(
                        color: Pallete.inputLabelTextColor,
                        fontSize: 12 // Adjust color as needed
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Pallete.buttonBgcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: Text('Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        color: Pallete.inputLabelTextColor,
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account?    ',
                      style: TextStyle(color: Pallete.inputLabelTextColor),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                              color: Pallete.inputLabelTextColor,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.push(context, SignUpScreen.route()),
                        )
                      ]),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
