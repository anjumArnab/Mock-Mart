import '../common/models/language_model.dart';

class AppConstants {

  // Base URL
  static const String baseUrl = 'BASE_URL';
  
  // API Endpoints
  static const String configUri = '/api/v1/config';
  static const String loginUri = '/api/v1/auth/login';
  static const String registerUri = '/api/v1/auth/register';
  static const String checkPhoneUri = '/api/v1/auth/check-phone';
  static const String verifyPhoneUri = '/api/v1/auth/verify-phone';
  static const String customerInfoUri = '/api/v1/customer/info';
  static const String updateProfileUri = '/api/v1/customer/update-profile';
  
  // SharedPreferences Keys
  static const String token = 'token';
  static const String userInfo = 'user_info';
  static const String languageCode = 'language_code';
  
  // Default language
  static const String defaultLanguageCode = 'en';

  static List<LanguageModel> languages = [
    LanguageModel(languageName: 'English', languageCode: 'en'),
    LanguageModel(languageName: 'বাংলা', languageCode: 'bn'),
  ];
}
