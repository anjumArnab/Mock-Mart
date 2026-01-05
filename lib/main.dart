import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/homescreen/controllers/product_controller.dart';
import 'package:mock_mart/features/language/controllers/language_controller.dart';
import 'package:mock_mart/features/map/controllers/coordinate_controller.dart';
import 'package:mock_mart/features/map/repo/coordinate_repo.dart';
import 'package:mock_mart/features/profile/controllers/user_controller.dart';
import 'package:mock_mart/features/profile/repo/user_repo.dart';
import 'package:mock_mart/theme/theme_controller.dart';
import 'package:mock_mart/helpers/route_helper.dart';
import 'package:mock_mart/helpers/app_translation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mock_mart/api/remote/api_client.dart';
import 'package:mock_mart/features/auth/repo/auth_repo.dart';
import 'package:mock_mart/features/auth/controller/auth_controller.dart';
import 'package:mock_mart/utils/app_constants.dart';
import 'firebase_options.dart';
import 'helpers/notification_helper.dart';
import 'package:mock_mart/theme/light_theme.dart';
import 'package:mock_mart/theme/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationHelper.initialize();
  await NotificationHelper.initializeFirebaseMessaging();

  await AppTranslations.loadTranslations();
  final sharedPreferences = await SharedPreferences.getInstance();

  final apiClient = ApiClient(
    appBaseUrl: AppConstants.baseUrl,
    sharedPreferences: sharedPreferences,
  );

  final authRepo = AuthRepo(
    apiClient: apiClient,
    sharedPreferences: sharedPreferences,
  );

  final userRepo = UserRepo(apiClient: apiClient);

  final coordinateRepo=CoordinateRepo(apiClient: apiClient);

  Get.put(LanguageController());
  Get.put(ThemeController(sharedPreferences: sharedPreferences));
  Get.put(AuthController(authRepo: authRepo));
  Get.put(UserController(userRepo: userRepo, authRepo: authRepo));
  Get.put(ProductController());
  Get.put(CoordinateController(coordinateRepo: coordinateRepo));

  runApp(const MockMart());
}

class MockMart extends StatelessWidget {
  const MockMart({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final authController = Get.find<AuthController>();

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          title: 'Mock Mart',
          debugShowCheckedModeBanner: false,
          locale: languageController.locale,
          translations: AppTranslations(),
          fallbackLocale: const Locale('en'),
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.themeMode,
          initialRoute: authController.isLoggedIn()
             ? RouteHelper.getMainRoute()
             : RouteHelper.getSignInRoute(),
          getPages: RouteHelper.routes,
        );
      },
    );
  }
}
