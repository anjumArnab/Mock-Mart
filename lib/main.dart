import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mock_mart/features/language/controllers/language_controller.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/features/homepage/home_page.dart';

void main() {
  Get.put(LanguageController());
  runApp(const MockMart());
}

class MockMart extends StatefulWidget {
  const MockMart({super.key});

  @override
  State<MockMart> createState() => _MockMartState();
}

class _MockMartState extends State<MockMart> {
  // Simple theme mode state
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    return GetMaterialApp(
      title: 'Mock Mart',
      debugShowCheckedModeBanner: false,
      locale: languageController.locale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: HomePage(onThemeToggle: toggleTheme),
    );
  }
}

