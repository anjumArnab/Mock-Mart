import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mock_mart/common/widgets/custom_snack_bar.dart';
import 'package:mock_mart/features/auth/models/sign_up_body.dart';
import 'package:mock_mart/features/auth/repo/auth_repo.dart';
import 'package:mock_mart/helpers/route_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _isActiveRememberMe = false;
  String _verificationCode = '';
  String countryDialCode = "+880";

  bool get isLoading => _isLoading;
  bool get acceptTerms => _acceptTerms;
  bool get isActiveRememberMe => _isActiveRememberMe;
  String get verificationCode => _verificationCode;

  @override
  void onInit() {
    super.onInit();
    countryDialCode = "+880";
  }

  Future<void> registration({required SignUpBody signUpBody}) async {
    _isLoading = true;
    update();

    try {
      Response response = await authRepo.register(signUpBody);

      if (response.statusCode == 200) {
        customSnackBar("registration_successful_please_verify_your_phone".tr, 
          type: ToasterMessageType.success);
        
       // Get.toNamed(RouteHelper.getVerificationRoute(
       //   phone: signUpBody.phone ?? '',
       // ));
      } else {
        String errorMessage = "registration_failed".tr;
        if (response.body != null && response.body is Map) {
          errorMessage = response.body['message'] ?? response.statusText ?? errorMessage;
        }
        customSnackBar(errorMessage);
      }
    } catch (e) {
      customSnackBar("an_error_occurred_during_registration".tr);
      if (kDebugMode) {
        print('Registration error: $e');
      }
    }

    _isLoading = false;
    update();
  }

  // Login
  Future<void> login({
    required String emailOrPhone,
    required String password,
    required String type,
  }) async {
    _isLoading = true;
    update();

    try {
      Response response = await authRepo.login(
        emailOrPhone: emailOrPhone,
        password: password,
        type: type,
      );

      if (response.statusCode == 200 && response.body != null) {
        String? token = response.body['token'];
        
        if (token != null && token.isNotEmpty) {
          await _saveTokenAndNavigate(token: token, emailOrPhone: emailOrPhone, password: password);
          customSnackBar("login_successful".tr, type: ToasterMessageType.success);
        } else {
          customSnackBar("login_failed_invalid_response_from_server".tr);
        }
      } else {
        String errorMessage = "login_failed".tr;
        if (response.body != null && response.body is Map) {
          errorMessage = response.body['message'] ?? response.statusText ?? errorMessage;
        }
        customSnackBar(errorMessage);
      }
    } catch (e) {
      customSnackBar("an_error_occurred_during_login".tr);
      if (kDebugMode) {
        print('Login error: $e');
      }
    }

    _isLoading = false;
    update();
  }

  Future<bool> checkPhone(String phone) async {
    _isLoading = true;
    update();

    try {
      Response response = await authRepo.checkPhone(phone);
      
      _isLoading = false;
      update();

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Check phone error: $e');
      }
      _isLoading = false;
      update();
      return false;
    }
  }

  Future<void> verifyPhone({
    required String phone,
    required String otp,
  }) async {
    _isLoading = true;
    update();

    try {
      Response response = await authRepo.verifyPhone(
        phone: phone,
        token: otp,
      );

      if (response.statusCode == 200 && response.body != null) {
        String? token = response.body['token'];
        
        if (token != null && token.isNotEmpty) {
          await _saveTokenAndNavigate(token: token, emailOrPhone: phone, password: '');
          customSnackBar("phone_verified_successfully".tr, type: ToasterMessageType.success);
        } else {
          customSnackBar("verification_failed_invalid_response_from_server".tr);
        }
      } else {
        String errorMessage = "verification_failed".tr;
        if (response.body != null && response.body is Map) {
          errorMessage = response.body['message'] ?? response.statusText ?? errorMessage;
        }
        customSnackBar(errorMessage);
      }
    } catch (e) {
      customSnackBar("an_error_occurred_during_verification".tr);
      if (kDebugMode) {
        print('Verify phone error: $e');
      }
    }

    _isLoading = false;
    update();
  }

  Future<void> logOut() async {
    await authRepo.clearSharedData();
    Get.offAllNamed(RouteHelper.getSignInRoute());
    customSnackBar("logged_out_successfully".tr, type: ToasterMessageType.success);
  }

  // Save token and navigate
  Future<void> _saveTokenAndNavigate({
    required String token,
    String? emailOrPhone,
    String? password,
  }) async {
    await authRepo.saveUserToken(token);

    if (_isActiveRememberMe && emailOrPhone != null && password != null) {
      // Save credentials if remember me is checked
      // This can be implemented in authRepo if needed
    }

    // Navigate to home
    Get.offAllNamed(RouteHelper.getMainRoute());
  }

  // Update verification code
  void updateVerificationCode(String code) {
    _verificationCode = code;
    update();
  }

    // Toggle terms acceptance
  void toggleTerms({bool? value, bool shouldUpdate = true}) {
    if (value != null) {
      _acceptTerms = value;
    } else {
      _acceptTerms = !_acceptTerms;
    }
    if (shouldUpdate) {
      update();
    }
  }

  // Toggle remember me
  void toggleRememberMe({bool? value, bool shouldUpdate = true}) {
    if (value != null) {
      _isActiveRememberMe = value;
    } else {
      _isActiveRememberMe = !_isActiveRememberMe;
    }
    if (shouldUpdate) {
      update();
    }
  }


  // Check if user is logged in
  bool isLoggedIn() => authRepo.isLoggedIn();

  // Get user token
  String getUserToken() => authRepo.getUserToken();

}