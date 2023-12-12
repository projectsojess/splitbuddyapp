import "package:flutter/material.dart";
import "package:splitbuddy/themes/pallete.dart";

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Pallete
                .secondaryColor; // Set the selected checkbox color to orange
          }
          return const Color.fromARGB(255, 29, 28, 28); // Set the default color
        },
      ),
    ),
  );
}
