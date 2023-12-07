import 'package:flutter/material.dart';
import 'package:splitbuddy/themes/pallete.dart';

class ExpenseField extends StatefulWidget {
  final TextEditingController editingController;
  final IconData icon;
  final String? Function(String?)? validator;
  final String label;
  final String? hintText;
  const ExpenseField(
      {super.key,
      required this.editingController,
      required this.icon,
      this.validator,
      required this.label,
      this.hintText});

  @override
  State<ExpenseField> createState() => _ExpenseFieldState();
}

class _ExpenseFieldState extends State<ExpenseField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(widget.icon),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: widget.editingController,
            validator: widget.validator,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.label,
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
