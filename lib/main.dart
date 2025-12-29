import 'package:flutter/material.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/views/home_page.dart';

void main() {
  runApp(const MockMart());
}

class MockMart extends StatelessWidget {
  const MockMart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mock Mart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: AppTheme.scaffoldBgColor,
      ),
      home: const HomePage(),
    );
  }
}