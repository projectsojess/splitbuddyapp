import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/constants/asset_constants.dart';
import 'package:splitbuddy/constants/ui_constants.dart';
import 'package:splitbuddy/dtos/country_data.dart';
import 'package:splitbuddy/dtos/user.dart';
import 'package:splitbuddy/feature/auth/views/login_view.dart';
import 'package:splitbuddy/feature/auth/widgets/auth_field.dart';
import 'package:splitbuddy/providers/country_provider.dart';
import 'package:splitbuddy/services/auth_services.dart';
import 'package:splitbuddy/themes/pallete.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static route() => MaterialPageRoute(builder: (context) => SignUpScreen());
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final String iconPathEmail = AssetConstants.envelope;
  final String iconPathPassword = AssetConstants.lock;
  final String iconPathDialpad = AssetConstants.dialpad;
  final AuthService authService = AuthService();

  void signUpUser() {
    authService.SignUpUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      username: 'test',
      phone: phoneNumberController.text != ''
          ? _selectedCountry!.code + phoneNumberController.text
          : '',
    );
  }

  void loadUserDetailScreen() {
    User userData = User(
      userId: 0,
      username: '',
      email: emailController.text,
      token: '',
      password: passwordController.text,
      currency: _selectedCountry!.currency,
      country: _selectedCountry!.name,
      phone: phoneNumberController.text != ''
          ? _selectedCountry!.code + phoneNumberController.text
          : '',
    );
    authService.checkUserExists(userData: userData, context: context);
  }

  // Initialize _countries as an empty list
  CountryData? _selectedCountry;

  @override
  void initState() {
    super.initState();
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
          child: Form(
            key: _formKey,
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
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
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
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Container(
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Phone',
                      style: TextStyle(
                        color: Pallete.inputLabelTextColor,
                        fontSize: 16,
                      ),
                    )),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Pallete.buttonBgcolor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Consumer<CountryProvider>(
                          builder: (context, countryProvider, child) {
                        List<CountryData> countries = countryProvider.countries;
                        if (countries.isEmpty) {
                          Navigator.pop(context, "not connected");
                        }
                        _selectedCountry = countries[0];
                        return DropdownButton<CountryData>(
                          value: _selectedCountry, // selected country value
                          onChanged: (CountryData? newValue) {
                            setState(() {
                              _selectedCountry = newValue;
                            });
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Pallete.inputFieldIconColor,
                          ),
                          elevation: 2,
                          underline: Container(),
                          items: countries.map<DropdownMenuItem<CountryData>>(
                              (CountryData country) {
                            return DropdownMenuItem<CountryData>(
                              value: country,
                              child: Row(
                                children: [
                                  UIConstants.getSVGIconSB(
                                      AssetConstants.getFullFlagPath(
                                          country.name)),
                                  SizedBox(width: 10),
                                  Text('(${country.code})'),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      child: Expanded(
                        child: TextFormField(
                          controller: phoneNumberController,
                          style: TextStyle(
                            color: Pallete.inputFieldTextColor,
                          ),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Pallete.inputFieldBgColor,
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                              hintText: '         (Optional)',
                              suffixIcon: UIConstants.getSVGIcon(
                                  iconPathDialpad, Pallete.inputFieldIconColor),
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
                      // signUpUser();
                      if (_formKey.currentState!.validate()) {
                        loadUserDetailScreen();
                      }
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
                              ..onTap = () => Navigator.push(
                                    context,
                                    LoginView.route(),
                                  ),
                          )
                        ]),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
