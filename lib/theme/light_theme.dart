import 'package:flutter/material.dart';
import 'custom_theme_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'Roboto',
  brightness: Brightness.light,
  primaryColor: const Color(0xFF1455AC),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF1455AC),
    secondary: Color(0xFFF58300),
    error: Color(0xFFFF5555),
    
    surface: Color(0xFFFFFFFF),
  ),
  
  extensions: <ThemeExtension<CustomThemeColors>>[
    CustomThemeColors.light(),
  ],
  
  // Additional theme properties
  cardColor: Colors.white,
  hintColor: const Color(0xFFA4A4A4),
  dividerColor: const Color(0xFFE0E0E0),
  
);