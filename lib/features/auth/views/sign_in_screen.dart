import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/auth/controller/auth_controller.dart';
import 'package:mock_mart/features/auth/widgets/auth_button.dart';
import 'package:mock_mart/features/auth/widgets/auth_text_field.dart';
import 'package:mock_mart/features/language/controllers/language_controller.dart';
import 'package:mock_mart/helpers/route_helper.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/theme/theme_controller.dart';
import 'package:mock_mart/utils/app_constants.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/gaps.dart';
import 'package:mock_mart/utils/text_styles.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final isDark = themeController.isDarkMode;
        
        return Scaffold(
          backgroundColor: AppTheme.getBackgroundColor(context),
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: AppTheme.primaryColor,
                ),
                onPressed: () => themeController.toggleTheme(),
                tooltip: isDark ? "enabled".tr : "disabled".tr,
              ),
              Icon(
                Icons.translate,
                color: AppTheme.primaryColor,
              ),
              Gaps.horizontalGapOf(Dimensions.paddingSizeSmall),
              DropdownButton<String>(
                value: Get.find<LanguageController>().locale.languageCode,
                underline: SizedBox(),
                icon: Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                items: AppConstants.languages.map((lang) {
                  return DropdownMenuItem(
                    value: lang.languageCode,
                    child: Text(
                      lang.languageName!,
                      style: interRegular.copyWith(
                        fontSize: 14,
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? code) {
                  if (code != null) {
                    Get.find<LanguageController>().setLanguage(Locale(code));
                  }
                },
              ),
              Gaps.horizontalGapOf(Dimensions.paddingSizeDefault),
            ],
          ),
          body: SafeArea(
            child: GetBuilder<AuthController>(
              builder: (authController) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),

                        Text(
                          'welcome_back'.tr,
                          style: encodeSansBold.copyWith(
                            fontSize: 28,
                            color: AppTheme.getTextColor(context),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'sign_in_to_continue'.tr,
                          style: encodeSansRegular.copyWith(
                            fontSize: 16,
                            color: AppTheme.getSecondaryTextColor(context),
                          ),
                        ),

                        const SizedBox(height: 40),

                        AuthTextField(
                          controller: _phoneController,
                          label: 'phone_number'.tr,
                          hint: 'hint_text'.tr,
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_your_phone_number'.tr;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        AuthTextField(
                          controller: _passwordController,
                          label: 'password'.tr,
                          hint: 'enter_your_password'.tr,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_your_password'.tr;
                            }
                            if (value.length < 6) {
                              return 'password_must_be_at_least_6_characters'.tr;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Checkbox(
                                    value: authController.isActiveRememberMe,
                                    onChanged: (value) {
                                      authController.toggleRememberMe(value: value);
                                    },
                                    activeColor: AppTheme.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'remember_me'.tr,
                                  style: interRegular.copyWith(
                                    fontSize: 14,
                                    color: AppTheme.getSecondaryTextColor(context),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.getForgotPasswordRoute());
                              },
                              child: Text(
                                'forgot_password'.tr,
                                style: interSemiBold.copyWith(
                                  fontSize: 14,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        AuthButton(
                          text: 'sign_in'.tr,
                          isLoading: authController.isLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authController.login(
                                emailOrPhone: _phoneController.text.trim(),
                                password: _passwordController.text,
                                type: 'phone',
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'dont_have_an_account'.tr,
                              style: interRegular.copyWith(
                                fontSize: 14,
                                color: AppTheme.getSecondaryTextColor(context),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.getSignUpRoute());
                              },
                              child: Text(
                                'sign_up'.tr,
                                style: interSemiBold.copyWith(
                                  fontSize: 14,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}