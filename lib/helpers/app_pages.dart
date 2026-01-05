import 'package:go_router/go_router.dart';
import 'package:mock_mart/features/auth/views/sign_in_screen.dart';
import 'package:mock_mart/features/auth/views/sign_up_screen.dart';
import 'package:mock_mart/features/auth/views/verification_screen.dart';
import 'package:mock_mart/utils/app_routes.dart';

class AppPages {
  // Prevent instantiation
  AppPages._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.signInScreen,

    routes: [
      GoRoute(
        path: AppRoutes.signInScreen,
        name: AppRoutes.signInScreen,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUpScreen,
        name: AppRoutes.signUpScreen,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.verificationScreen,
        name: AppRoutes.verificationScreen,
        builder: (context, state) {
          final phone = state.pathParameters['phone'] ?? '';
          return VerificationScreen(phone: phone);
        },
      ),
    ],
    errorBuilder: (context, state) => SignInScreen(),
  );
}