import 'package:flutter/material.dart';
import 'package:splitbuddy/constants/asset_constants.dart';
import 'package:splitbuddy/constants/ui_constants.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconPath;
  final bool obscureText;
  final String? Function(String?)? validator;
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconPath,
    required this.obscureText,
    required this.validator,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    IconData getLockIcon() {
      return _obscureText ? Icons.lock : Icons.lock_open;
    }

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      style: TextStyle(
        color: Pallete.inputFieldTextColor,
      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: Pallete.inputFieldBgColor,
          hintText: widget.hintText,
          suffixIcon: widget.iconPath == AssetConstants.lock
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Toggle password visibility
                    });
                  },
                  child: Icon(
                    getLockIcon(),
                    color: Pallete.inputFieldIconColor,
                  ),
                )
              : widget.iconPath == ''
                  ? null
                  : UIConstants.getSVGIcon(
                      widget.iconPath, Pallete.inputFieldIconColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          )),
    );
  }
}
