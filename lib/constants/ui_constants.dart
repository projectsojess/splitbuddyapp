import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:splitbuddy/feature/auth/views/login_view.dart";
import "package:splitbuddy/themes/pallete.dart";

class UIConstants {
  static const String COULD_NOT_PROCESS_ERROR_MESSAGE =
      "Could not process request. Please try again later";

  static const String IMAGE_PERMMISSION_REQUIRED =
      'Please grant permission to gallery for selecting images or click cancel to continue without an image.';

  static const String CANT_EDIT_EXPENSE =
      "You can't edit an expense that you're not involved";

  static const String GROUP_LENT = "You'll get";
  static const String GROUP_OWE = "You owe";

  static Map<String, String> _unicodeMap = {"INR": "₹", "USD": "\$"};

  static Map<String, IconData> _currencyIconMap = {
    "INR": Icons.currency_rupee_sharp,
    "USD": Icons.attach_money_outlined
  };

  static String? getUnicode(String key) {
    return _unicodeMap[key];
  }

  static IconData? getCurrencyIcon(String key) {
    return _currencyIconMap[key];
  }

  static Text getAppTitle(double fontSize) {
    return Text(
      'SplitBuddies',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: 'Source Sans Pro',
        color: Pallete.textColor,
      ),
    );
  }

  static Text getText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Source Sans Pro',
        color: Pallete.textColor,
      ),
    );
  }

  static SizedBox getSVGIcon(String iconPath, Color color) {
    return SizedBox(
        child: Transform.scale(
      scale: 0.5,
      child: SvgPicture.asset(
        iconPath,
        color: color,
        height: 10,
        width: 10,
      ),
    ));
  }

  static SizedBox getSVGIconSB(String iconPath) {
    return SizedBox(
        child: Transform.scale(
      scale: 0.8,
      child: SvgPicture.asset(
        iconPath,
        height: 20,
        width: 20,
      ),
    ));
  }

  static Future<Object?> getLoginScreen(BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginView()));
  }

  static Switch getSwitch(onchage, value) {
    return Switch(
      activeTrackColor: Pallete.secondaryColor,
      inactiveTrackColor: Pallete.backgroundColor,
      trackOutlineColor:
          MaterialStateProperty.all<Color>(Pallete.secondaryColor),
      inactiveThumbColor: Pallete.secondaryColor,
      value: value, // Replace with actual user preference
      onChanged: (value) {
        // Implement logic to update user's notification preference
      },
    );
  }
}
