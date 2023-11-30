import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseField extends StatelessWidget {
  final TextEditingController editingController;
  final IconData icon;
  final String label;
  final String? Function(String?)? validator;
  const ExpenseField(
      {super.key,
      required this.editingController,
      required this.icon,
      required this.validator,
      required this.label});

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
              labelText: label,
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
