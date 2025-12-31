import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const MenuPage({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.getTextColor(context),
              ),
            ),
            subtitle: Text(
              isDark ? 'Enabled' : 'Disabled',
              style: TextStyle(
                color: AppTheme.getSecondaryTextColor(context),
              ),
            ),
            value: isDark,
            onChanged: (value) {
              onThemeToggle();
            },
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: AppTheme.primaryColor,
            ),
          ),

        ],
      ),
    );
  }
}