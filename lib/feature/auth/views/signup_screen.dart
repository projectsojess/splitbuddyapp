import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:splitbuddy/constants/asset_constants.dart';
import 'package:splitbuddy/constants/ui_constants.dart';
import 'package:splitbuddy/dtos/country.dart';
import 'package:splitbuddy/feature/auth/widgets/auth_field.dart';
import 'package:splitbuddy/themes/pallete.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final String iconPathEmail = AssetConstants.envelope;
  final String iconPathPassword = AssetConstants.lock;
  final List<Country> _countries = [
    Country(name: 'INDIA', code: '+91'),
    Country(name: 'USA', code: '+1')
  ];
  Country? _selectedCountry;
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
                      AssetConstants.signupScreenImage,
                      height: 250,
                    ),
                    UIConstants.getAppTitle(32),
                    SizedBox(
                      height: 10.0,
                    ),
                    UIConstants.getText(
                        'Create an account to track and split expenses', 16.0)
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
                controller: passwordController,
                hintText: 'Enter your password',
                iconPath: iconPathPassword,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Pallete.buttonBgcolor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: DropdownButton<Country>(
                      value: _countries[0], // selected country value
                      onChanged: (Country? newValue) {
                        setState(() {
                          _selectedCountry = newValue!;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Pallete.authIconsColor,
                      ),
                      elevation: 2,
                      underline: Container(),
                      items: _countries
                          .map<DropdownMenuItem<Country>>((Country country) {
                        return DropdownMenuItem<Country>(
                          value: country,
                          child: Row(
                            children: [
                              UIConstants.getSVGIconSB(
                                  AssetConstants.getFullFlagPath(country.name)),
                              SizedBox(width: 10),
                              Text('(${country.code})'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    child: Expanded(
                      child: TextFormField(
                        controller: TextEditingController(),
                        style: TextStyle(
                          color: Pallete.inputFieldTextColor,
                        ),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Pallete.inputFieldBgColor,
                            hintText: 'Enter your phone nunber',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign-in action
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Pallete.buttonBgcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: Text('Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Pallete.inputLabelTextColor,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: 'Already have an account?    ',
                      style: TextStyle(color: Pallete.inputLabelTextColor),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                              color: Pallete.inputLabelTextColor,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => UIConstants.getLoginScreen(context),
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
