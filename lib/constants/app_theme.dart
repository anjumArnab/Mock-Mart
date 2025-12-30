import 'package:flutter/material.dart';

class AppTheme {
  // Common Colors
  static const Color primaryColor = Color(0xFF1455AC);
  static const Color secondaryColor = Color(0xFFF58300);
  static const Color red = Color(0xFFFF5555);
  static const Color success = Color(0xFF00AA6D);
  static const Color warning = Color(0xFFFFAD31);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: red,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Color(0xFF02070E),
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: red,
    ),
  );

  // Helper method to get colors based on theme
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xFF02070E)
        : Color(0xFFFFFFFF);
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xFF1A1F2E)
        : Color(0xFFFFFFFF);
  }

  static Color getTextColor(BuildContext context) {

    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xFFFCFCFC)
        : Color(0xFF000000);
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0xFFAFB1B5)
        : Color(0xFF595959);
  }

  static Color getInactiveColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0x1AE9F3FF)
        : Color(0x1AAFAFAF);
  }

  static Color getSectionBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Color(0x1AAFAFAF)
        : Color(0xFFF3F6F8);
  }

  static Color getSearchBarBackground(BuildContext context) {
    //return Color(0xFF595959);
    return Theme.of(context).brightness == Brightness.dark ? Color(0xFF595959) : Color(0xFFFCFCFC);
  }

  static Color getGreyTextColor(BuildContext context) {
    return Color(0xFF808080);
  }

  static Color getNegativeColor(BuildContext context) {
    return Color(0x99FF5555);
  }
}