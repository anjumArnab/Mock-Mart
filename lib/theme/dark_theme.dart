import 'package:flutter/material.dart';
import 'custom_theme_colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  fontFamily: 'Roboto',
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF1455AC),
  scaffoldBackgroundColor: const Color(0xFF02070E),
  
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF1455AC),
    secondary: Color(0xFFF58300),
    error: Color(0xFFFF5555),
    surface: Color(0xFF02070E),
  ),
  
  extensions: <ThemeExtension<CustomThemeColors>>[
    CustomThemeColors.dark(),
  ],
  
  // Additional theme properties
  cardColor: const Color(0xFF1A1F2E),
  hintColor: const Color(0xFFAFB1B5),
  dividerColor: const Color(0xFF2A2F3E),
);