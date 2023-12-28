import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:splitbuddy/feature/auth/views/login_view.dart";
import "package:splitbuddy/themes/pallete.dart";

class UIConstants {
  static const String COULD_NOT_PROCESS_ERROR_MESSAGE =
      "Could not process request. Please try again later";

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
}
