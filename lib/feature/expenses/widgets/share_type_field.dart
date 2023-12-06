import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ShareTypeField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String shareType;
  final IconData icon;
  const ShareTypeField(
      {super.key,
      required this.controller,
      required this.name,
      required this.shareType,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Pallete.inputLabelTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 60, // Width of the input field
          child: TextField(
            textAlign: TextAlign.center, // Center align text
            controller: controller,
            keyboardType: TextInputType.number,
            cursorColor: Pallete.secondaryColor,
            decoration: InputDecoration(
              hintText: shareType == 'P' ? ' %' : 'shares',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Pallete.inputLabelTextColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Pallete.secondaryColor,
                ),
              ),
            ),
          ),
        ),
        // Placeholder for logo/icon
        Icon(icon), // Replace this with your desired icon
      ],
    );
  }
}
