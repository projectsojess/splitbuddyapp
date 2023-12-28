import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/constants/ui_constants.dart';
import 'package:splitbuddy/dtos/country_data.dart';
import 'package:splitbuddy/dtos/user.dart';
import 'package:splitbuddy/providers/country_provider.dart';
import 'package:splitbuddy/services/service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class UserDetailScreen extends StatefulWidget {
  static route({required User userData, required BuildContext context}) =>
      MaterialPageRoute(
          builder: (context) => UserDetailScreen(
                userData: userData,
              ));
  final User userData;
  const UserDetailScreen({
    super.key,
    required this.userData,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  CountryData? _selectedCurrency; // Default currency
  TextEditingController usernameController = TextEditingController();
  File? _image;

  final picker = ImagePicker();
  _requestGalleryPermission() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      final status = await Permission.photos.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        print(status.isPermanentlyDenied);
        showPopup(context);
      }
    }
  }

  void showPopup(context) => showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Permission Denied'),
            content: const Text(UIConstants.IMAGE_PERMMISSION_REQUIRED),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () => openAppSettings(),
              ),
            ],
          ));

  @override
  void initState() {
    super.initState();
  }

  void signup() {
    if (_image != null) {
      String base64Image = base64Encode(_image!.readAsBytesSync());
    }

    User userData = User(
      userId: 0,
      username: usernameController.text,
      email: widget.userData.email,
      token: '',
      password: widget.userData.password,
      currency: _selectedCurrency!.currency,
      country: widget.userData.country,
    );

    authService.SignUpUser(context: context, userData: userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await _requestGalleryPermission();
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontStyle: FontStyle.italic),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Pallete.inputLabelTextColor,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Pallete.secondaryColor,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Pallete.inputLabelTextColor,
                          ),
                        ),
                        cursorColor: Pallete.secondaryColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a username';
                          } else if (!RegExp(r'^[a-zA-Z0-9]*$')
                              .hasMatch(value)) {
                            return ' only  letters and numbers allowed';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Select currency',
                      style: TextStyle(
                        color: Pallete.textColor,
                        fontSize: 20,
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Consumer<CountryProvider>(
                        builder: (context, countryProvider, child) {
                      List<CountryData> countries = countryProvider.countries;
                      _selectedCurrency = countries[0];
                      return DropdownButton<CountryData>(
                        value: _selectedCurrency,
                        onChanged: (CountryData? newValue) {
                          setState(() {
                            _selectedCurrency = newValue!;
                          });
                        },
                        items: countries.map<DropdownMenuItem<CountryData>>(
                            (CountryData value) {
                          return DropdownMenuItem<CountryData>(
                            value: value,
                            child: Text(value.currency),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 20.0),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Pallete.secondaryColor),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signup();
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Pallete.textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
