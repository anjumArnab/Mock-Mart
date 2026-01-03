import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/auth/controller/auth_controller.dart';
import 'package:mock_mart/features/auth/models/sign_up_body.dart';
import 'package:mock_mart/features/auth/widgets/auth_button.dart';
import 'package:mock_mart/features/auth/widgets/auth_text_field.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.getTextColor(context),
          ),
          onPressed: () => Get.back(),
        ),
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
                    Text(
                      'create_account'.tr,
                      style: encodeSansBold.copyWith(
                        fontSize: 28,
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'sign_up_to_get_started'.tr,
                      style: encodeSansRegular.copyWith(
                        fontSize: 16,
                        color: AppTheme.getSecondaryTextColor(context),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    AuthTextField(
                      controller: _firstNameController,
                      label: 'first_name'.tr,
                      hint: 'enter_your_first_name'.tr,
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_your_first_name'.tr;
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    AuthTextField(
                      controller: _lastNameController,
                      label: 'last_name'.tr,
                      hint: 'enter_your_last_name'.tr,
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_your_last_name'.tr;
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
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
                      controller: _emailController,
                      label: 'email'.tr,
                      hint: 'enter_your_email'.tr,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please_enter_your_email'.tr;
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'please_enter_a_valid_email'.tr;
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
                        if (value.length < 8) {
                          return 'password_must_be_at_least_8_characters'.tr;
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    AuthTextField(
                      controller: _referralCodeController,
                      label: 'referral_code_optional'.tr,
                      hint: 'enter_referral_code'.tr,
                      icon: Icons.card_giftcard_outlined,
                      isRequired: false,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: authController.acceptTerms,
                            onChanged: (value) {
                              authController.toggleTerms(value: value);
                            },
                            activeColor: AppTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Wrap(
                            children: [
                              Text(
                                'i_agree_to_the'.tr,
                                style: interRegular.copyWith(
                                  fontSize: 14,
                                  color: AppTheme.getSecondaryTextColor(context),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                },
                                child: Text(
                                  'terms_and_conditions'.tr,
                                  style: interSemiBold.copyWith(
                                    fontSize: 14,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    AuthButton(
                      text: 'sign_up'.tr,
                      isLoading: authController.isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (!authController.acceptTerms) {
                            Get.snackbar(
                              'terms_required'.tr,
                              'please_accept_the_terms_and_conditions'.tr,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppTheme.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                          
                          final signUpBody = SignUpBody(
                            fName: _firstNameController.text.trim(),
                            lName: _lastNameController.text.trim(),
                            phone: _phoneController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                            referralCode: _referralCodeController.text.trim(),
                          );
                          
                          authController.registration(signUpBody: signUpBody);
                        }
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already_have_an_account'.tr,
                          style: interRegular.copyWith(
                            fontSize: 14,
                            color: AppTheme.getSecondaryTextColor(context),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'sign_in'.tr,
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
  }
}