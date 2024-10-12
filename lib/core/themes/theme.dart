import 'package:flutter/material.dart';
import './app_pallete.dart';

class AppTheme {
  static const String _fontFamily = 'Poppins';

  // Define the border decoration for input fields.
  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 3,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  // Input decoration theme to maintain consistency across themes.
  static InputDecorationTheme _inputDecorationTheme({
    required Color focusedColor,
    required Color errorColor,
  }) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(focusedColor),
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
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
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
      focusedColor: AppPallete.gradient2,
      errorColor: AppPallete.errorColor,
    ),
    textTheme: _textTheme(Colors.white),
    chipTheme: _chipTheme(AppPallete.backgroundColor, Colors.white),
  );

  // Define the light theme mode using the default light theme.
  static final ThemeData lightThemeMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: _fontFamily,
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
      focusedColor: AppPallete.gradient2,
      errorColor: AppPallete.errorColor,
    ),
    textTheme: _textTheme(Colors.black),
    chipTheme: _chipTheme(AppPallete.backgroundColor, Colors.black),
  );
}
