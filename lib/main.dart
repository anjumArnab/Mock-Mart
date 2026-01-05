import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/features/homescreen/controllers/product_controller.dart';
import 'package:mock_mart/features/language/controllers/language_controller.dart';
import 'package:mock_mart/features/profile/controllers/user_controller.dart';
import 'package:mock_mart/features/profile/repo/user_repo.dart';
import 'package:mock_mart/theme/app_theme.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationHelper.initialize();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('=======FCM Token: $fcmToken=========');

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

  Get.put(LanguageController());
  Get.put(ThemeController(sharedPreferences: sharedPreferences));
  Get.put(AuthController(authRepo: authRepo));
  Get.put(UserController(userRepo: userRepo, authRepo: authRepo));
  Get.put(ProductController());

  runApp(const MockMart());
}

class MockMart extends StatefulWidget {
  const MockMart({super.key});

  @override
  State<MockMart> createState() => _MockMartState();
}

class _MockMartState extends State<MockMart> {
  @override
  void initState() {
    super.initState();
    _setupNotificationListeners();
  }

  void _setupNotificationListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received');
      print(message.notification?.title);
      print(message.notification?.body);
      NotificationHelper.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification opened from terminated or background state');
      if (message.data.containsKey('screen')) {
        _handleNotificationRoute(message.data['screen']);
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null && message.data.containsKey('screen')) {
        print('App opened from terminated state via notification');
        Future.delayed(const Duration(milliseconds: 500), () {
          _handleNotificationRoute(message.data['screen']);
        });
      }
    });
  }

  void _handleNotificationRoute(String screen) {
    if (screen == 'profile') {
      Get.toNamed(RouteHelper.getUserProfilePageRoute());
    }
  }

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
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
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
