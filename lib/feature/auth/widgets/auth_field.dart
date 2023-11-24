import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const AuthField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Pallete.inputFieldTextColor,
      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: Pallete.inputFieldBgColor,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          )),
    );
  }
}
