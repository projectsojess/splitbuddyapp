import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:splitbuddy/dtos/user.dart';
import 'package:splitbuddy/feature/auth/widgets/auth_field.dart';
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
  String selectedCurrency = 'USD'; // Default currency
  TextEditingController usernameController = TextEditingController();
  File? _image;

  final picker = ImagePicker();
  Future<void> requestGalleryPermission() async {
    final status = await Permission.photos.request();

    try {
      if (status.isDenied || status.isPermanentlyDenied) {
        showPopup();
      } else {
        getImage();
      }
    } catch (e) {
      showPopup();
    }
  }

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Permission Required'),
        content: Text(
            'Please grant permission to access the gallery for selecting images. Or continue without an image.'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.userData.currency = widget.userData.country;
    // selectedCurrency = widget.userData.currency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      await requestGalleryPermission();
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
                    child: TextField(
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
                      onChanged: (value) {
                        setState(() {
                          widget.userData.username = value;
                        });
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
                  DropdownButton<String>(
                    value: selectedCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                    items: <String>['USD', 'EUR', 'GBP', 'JPY', 'INR']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Pallete.secondaryColor),
                ),
                onPressed: () {
                  // Perform action on button press (e.g., save data)
                  // You can access 'username', 'selectedCurrency', and '_image' here
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
    );
  }
}
