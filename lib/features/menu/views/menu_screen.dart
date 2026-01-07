import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/language/controllers/language_controller.dart';
import 'package:mock_mart/helpers/route_helper.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/theme/theme_controller.dart';
import 'package:mock_mart/utils/app_constants.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/gaps.dart';
import 'package:mock_mart/utils/text_styles.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  bool isExpanded = true;

  void toggleAnimation() {
    if (isExpanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    isExpanded = !isExpanded;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _sizeAnimation = Tween<double>(
      begin: 100,
      end: 450,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final isDark = themeController.isDarkMode;

        return Scaffold(
          appBar: AppBar(
            title: Text("menu".tr),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: ListView(
            children: [
              SwitchListTile(
                title: Text(
                  "dark_mode".tr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(
                      context,
                    ).extension<CustomThemeColors>()!.textColor,
                  ),
                ),
                subtitle: Text(
                  isDark ? "enabled".tr : "disabled".tr,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                value: isDark,
                onChanged: (_) {
                  themeController.toggleTheme();
                },
                secondary: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              Row(
                children: [
                  Gaps.horizontalGapOf(Dimensions.paddingSizeDefault),
                  const Icon(Icons.translate),
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
                        Get.find<LanguageController>().setLanguage(
                          Locale(code),
                        );
                      }
                    },
                  ),
                ],
              ),

              IconButton(
                onPressed: () => Get.toNamed(RouteHelper.getMapScreen()),
                icon: const Icon(Icons.map_rounded, size: 50),
              ),

              Gaps.verticalGapOf(75),

              AnimatedBuilder(
                animation: _sizeAnimation,
                builder: (context, child) {
                  return Container(
                    width: _sizeAnimation.value,
                    height: _sizeAnimation.value,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                },
              ),

              Gaps.verticalGapOf(75),

              IconButton(
                onPressed: () => Get.toNamed(RouteHelper.getAnimationScreen()),
                icon: const Icon(Icons.animation_outlined, size: 50),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: toggleAnimation,
            child: const Icon(Icons.play_arrow),
          ),
        );
      },
    );
  }
}
