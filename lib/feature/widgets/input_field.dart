import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class InputField extends StatelessWidget {
  final TextEditingController editingController;
  final TextInputType inputType;
  final IconData icon;
  final String label;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  const InputField(
      {super.key,
      required this.editingController,
      required this.inputType,
      required this.icon,
      required this.label,
      required this.validator,
      this.onChange});

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
            onChanged: onChange,
            keyboardType: inputType,
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
