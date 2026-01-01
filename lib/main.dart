import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/language/controllers/language_controller.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/features/homepage/home_page.dart';

import 'helpers/app_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppTranslations.loadTranslations();

  Get.put(LanguageController());

  runApp(const MockMart());
}

class MockMart extends StatefulWidget {
  const MockMart({super.key});

  @override
  State<MockMart> createState() => _MockMartState();
}

class _MockMartState extends State<MockMart> {
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
      translations: AppTranslations(),
      fallbackLocale: Locale('en'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: HomePage(onThemeToggle: toggleTheme),
    );
  }
}