import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/features/homepage/home_page.dart';

void main() {
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
    return MaterialApp(
      title: 'Mock Mart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: HomePage(onThemeToggle: toggleTheme),
    );
  }
}

