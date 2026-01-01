import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import '../../utils/app_constants.dart';
import '../../utils/gaps.dart';
import '../language/controllers/language_controller.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const MenuPage({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("menu".tr),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              "dark_mode".tr,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.getTextColor(context),
              ),
            ),
            subtitle: Text(
              isDark ? "enabled".tr : "disabled".tr,
              style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
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
          Row(
            children: [
              Gaps.horizontalGapOf(Dimensions.paddingSizeDefault),
              Icon(Icons.translate),
              Gaps.horizontalGapOf(Dimensions.paddingSizeDefault),
              DropdownButton<String>(
                value: Get.find<LanguageController>().locale.languageCode,
                items: AppConstants.languages.map((lang) {
                  return DropdownMenuItem(
                    value: lang.languageCode,
                    child: Text(lang.languageName!),
                  );
                }).toList(),
                onChanged: (String? code) {
                  if (code != null) {
                    Get.find<LanguageController>().setLanguage(Locale(code));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
