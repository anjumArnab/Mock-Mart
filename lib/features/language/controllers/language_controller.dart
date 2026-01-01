import 'dart:ui';
import 'package:get/get.dart';
import '../../../utils/app_constants.dart';

class LanguageController extends GetxController {
  Locale _locale = Locale(AppConstants.languages[0].languageCode!);

  Locale get locale => _locale;

  void setLanguage(Locale locale) {
    _locale = locale;
    Get.updateLocale(locale);
    update();
  }
}