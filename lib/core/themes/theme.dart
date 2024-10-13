import 'package:flutter/material.dart';
import './app_pallete.dart';

class AppTheme {
  static const String _fontFamily = 'Poppins';

  // Define the border decoration for input fields.
  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static OutlineInputBorder _radius() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    );
  }

  // Input decoration theme to maintain consistency across themes.
  static InputDecorationTheme _inputDecorationTheme({
    required Color errorColor,
  }) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.all(17),
      filled: true, // Enables the fill color
      fillColor: Colors.grey.withOpacity(0.1),
      border: _border(),
      enabledBorder: _radius(),
      focusedBorder: _border(const Color.fromARGB(255, 181, 181, 181)),
      errorBorder: _border(errorColor),
    );
  }

  // Define the base text theme for common typography.
  static TextTheme _textTheme(Color textColor) {
    return TextTheme(
      bodyMedium: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  // Define the base chip theme for consistency across themes.
  static ChipThemeData _chipTheme(Color backgroundColor, Color labelColor) {
    return ChipThemeData(
      shape: const StadiumBorder(),
      backgroundColor: backgroundColor,
      side: BorderSide.none,
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        color: labelColor,
      ),
    );
  }

  // Define the dark theme mode using the default dark theme.
  static final ThemeData darkThemeMode = ThemeData(
    primaryColor: AppPallete.backgroundColorDark,
    primaryColorDark: AppPallete.backgroundColor,
    primaryColorLight: AppPallete.backgroundColorDark,
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    splashColor:
        Colors.grey.withOpacity(0.2), // Custom splash color for dark theme
    colorScheme: const ColorScheme.dark(
        primary: AppPallete.backgroundColorDark, secondary: Colors.grey),
  ).copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColorDark,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 23,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: _inputDecorationTheme(
      errorColor: AppPallete.errorColor,
    ),
    textTheme: _textTheme(Colors.white),
    chipTheme: _chipTheme(AppPallete.backgroundColor, Colors.white),
  );

  // Define the light theme mode using the default light theme.
  static final ThemeData lightThemeMode = ThemeData(
    primaryColor: AppPallete.backgroundColor,
    primaryColorDark: AppPallete.backgroundColorDark,
    primaryColorLight: AppPallete.backgroundColor,
    brightness: Brightness.light,
    fontFamily: _fontFamily,
    splashColor:
        Colors.grey.withOpacity(0.2), // Custom splash color for light theme
    colorScheme: const ColorScheme.light(
      primary: AppPallete.backgroundColor,
      secondary: Colors.grey, // Custom accent color for light theme
    ),
  ).copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 23,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: _inputDecorationTheme(
      errorColor: AppPallete.errorColor,
    ),
    textTheme: _textTheme(Colors.black),
    chipTheme: _chipTheme(AppPallete.backgroundColor, Colors.black),
  );
}
