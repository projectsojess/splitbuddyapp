import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/constants/ui_constants.dart';
import 'package:splitbuddy/themes/pallete.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackbar(context, jsonDecode(response.body)['message']);
      break;
    default:
      showSnackbar(context, UIConstants.COULD_NOT_PROCESS_ERROR_MESSAGE);
  }
}

InputDecoration customInputFieldDecoration(String hintText, String label) {
  return InputDecoration(
    hintText: hintText,
    labelText: label,
    hintStyle: TextStyle(
        color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
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
  );
}

Row getUnderLine() {
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          width: 10,
        ),
      ),
    ],
  );
}
