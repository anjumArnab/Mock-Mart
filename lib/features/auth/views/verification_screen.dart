import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/auth/controller/auth_controller.dart';
import 'package:mock_mart/features/auth/widgets/auth_button.dart';
import 'package:mock_mart/features/auth/widgets/otp_input_field.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/text_styles.dart';

class VerificationScreen extends StatefulWidget {
  final String phone;
  
  const VerificationScreen({super.key, required this.phone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String _getOtp() {
    return _otpControllers.map((controller) => controller.text).join();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.message_outlined,
                      size: 40,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  Text(
                    'verification_code'.tr,
                    style: encodeSansBold.copyWith(
                      fontSize: 28,
                      color: AppTheme.getTextColor(context),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    'we_have_sent_a_verification_code_to'.tr,
                    textAlign: TextAlign.center,
                    style: encodeSansRegular.copyWith(
                      fontSize: 16,
                      color: AppTheme.getSecondaryTextColor(context),
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    widget.phone,
                    style: interSemiBold.copyWith(
                      fontSize: 16,
                      color: AppTheme.getTextColor(context),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return OTPInputField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                          
                          if (index == 5 && value.isNotEmpty) {
                            String otp = _getOtp();
                            if (otp.length == 6) {
                              authController.verifyPhone(
                                phone: widget.phone,
                                otp: otp,
                              );
                            }
                          }
                        },
                      );
                    }),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'didnt_receive_code'.tr,
                        style: interRegular.copyWith(
                          fontSize: 14,
                          color: AppTheme.getSecondaryTextColor(context),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.snackbar(
                            'otp_sent'.tr,
                            'verification_code_has_been_resent'.tr,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppTheme.success,
                            colorText: Colors.white,
                          );
                        },
                        child: Text(
                          'resend'.tr,
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
                    text: 'verify'.tr,
                    isLoading: authController.isLoading,
                    onPressed: () {
                      String otp = _getOtp();
                      if (otp.length != 6) {
                        Get.snackbar(
                          'invalid_otp'.tr,
                          'please_enter_the_complete_6_digit_code'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppTheme.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      authController.verifyPhone(
                        phone: widget.phone,
                        otp: otp,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}