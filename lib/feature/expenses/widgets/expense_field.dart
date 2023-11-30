import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseField extends StatelessWidget {
  final TextEditingController editingController;
  final IconData icon;
  final String label;
  final String? hintText;
  final String? Function(String?)? validator;
  const ExpenseField(
      {super.key,
      required this.editingController,
      required this.icon,
      required this.validator,
      required this.label,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: editingController,
            validator: validator,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: hintText,
              labelText: label,
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
          ),
        ),
      ],
    );
  }
}
