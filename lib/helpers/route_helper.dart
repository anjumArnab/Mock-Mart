import 'package:get/get.dart';
import 'package:mock_mart/features/auth/views/sign_in_screen.dart';
import 'package:mock_mart/features/auth/views/sign_up_screen.dart';
import 'package:mock_mart/features/auth/views/verification_screen.dart';
import 'package:mock_mart/features/homepage/home_page.dart';

class RouteHelper {
  static const String _home = '/home';
  static const String _signIn = '/sign-in';
  static const String _signUp = '/sign-up';
  static const String _verification = '/verification';
  static const String _forgotPassword = '/forgot-password';
  static const String _main = '/main';

  // Route getters
  static String getMainRoute() => _main;
  
  static String getSignInRoute() => _signIn;
  
  static String getSignUpRoute() => _signUp;
  
  static String getVerificationRoute({String? phone}) {
    if (phone != null) {
      return '$_verification?phone=$phone';
    }
    return _verification;
  }
  
  static String getForgotPasswordRoute() => _forgotPassword;
  
  static String getHomeRoute() => _home;

  static List<GetPage> routes = [
    GetPage(
      name: _signIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: _signUp,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: _verification,
      page: () {
        final phone = Get.parameters['phone'] ?? '';
        return VerificationScreen(phone: phone);
      },
    ),
    GetPage(
      name: _main,
      page: () => const HomePage(),
    ),
    GetPage(
      name: _home,
      page: () => const HomePage(),
    ),
  ];
}