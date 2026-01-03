import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final SharedPreferences sharedPreferences;
  
  ThemeController({required this.sharedPreferences});

  static const String _themeKey = 'theme_mode';
  
  final Rx<ThemeMode> _themeMode = ThemeMode.dark.obs;
  ThemeMode get themeMode => _themeMode.value;
  
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  void _loadThemeFromPrefs() {
    final savedTheme = sharedPreferences.getString(_themeKey);
    if (savedTheme == 'light') {
      _themeMode.value = ThemeMode.light;
    } else if (savedTheme == 'dark') {
      _themeMode.value = ThemeMode.dark;
    } else {
      _themeMode.value = ThemeMode.dark;
    }
  }

  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      _themeMode.value = ThemeMode.dark;
      sharedPreferences.setString(_themeKey, 'dark');
    } else {
      _themeMode.value = ThemeMode.light;
      sharedPreferences.setString(_themeKey, 'light');
    }
    update();
  }

  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;
    sharedPreferences.setString(_themeKey, mode == ThemeMode.light ? 'light' : 'dark');
    update();
  }
}