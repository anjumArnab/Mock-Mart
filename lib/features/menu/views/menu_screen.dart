import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/language/controllers/language_controller.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/theme/theme_controller.dart';
import 'package:mock_mart/utils/app_constants.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/gaps.dart';


class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final isDark = themeController.isDarkMode;
        
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
                  themeController.toggleTheme();
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
      },
    );
  }
}