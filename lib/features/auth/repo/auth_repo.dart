import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mock_mart/api/remote/api_client.dart';
import 'package:mock_mart/features/auth/models/sign_up_body.dart';
import 'package:mock_mart/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getConfig() async {
    return await apiClient.getData(AppConstants.configUri);
  }

  Future<Response> login({
    required String emailOrPhone,
    required String password,
    required String type,
  }) async {
    return await apiClient.postData(
      AppConstants.loginUri,
      {
        "email_or_phone": emailOrPhone,
        "password": password,
        "type": type,
      },
    );
  }

  Future<Response> register(SignUpBody signUpBody) async {
    return await apiClient.postData(
      AppConstants.registerUri,
      signUpBody.toJson(),
    );
  }

  Future<Response> checkPhone(String phone) async {
    return await apiClient.getData(
      AppConstants.checkPhoneUri,
      query: {'phone': phone},
    );
  }

  Future<Response> verifyPhone({
    required String phone,
    required String token,
  }) async {
    return await apiClient.postData(
      AppConstants.verifyPhoneUri,
      {
        "phone": phone,
        "token": token,
      },
    );
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(
      token,
      sharedPreferences.getString(AppConstants.languageCode),
    );
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.token);
    await sharedPreferences.remove(AppConstants.userInfo);
    apiClient.token = null;
    apiClient.updateHeader(null, sharedPreferences.getString(AppConstants.languageCode));
    return true;
  }

  Future<bool> saveUserInfo(String userInfo) async {
    return await sharedPreferences.setString(AppConstants.userInfo, userInfo);
  }

  String getUserInfo() {
    return sharedPreferences.getString(AppConstants.userInfo) ?? "";
  }
}