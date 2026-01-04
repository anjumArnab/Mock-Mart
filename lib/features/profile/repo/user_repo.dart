import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mock_mart/api/remote/api_client.dart';
import 'package:mock_mart/utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserProfile() async {
    return await apiClient.getData(AppConstants.customerInfoUri);
  }

  Future<Response> updateUserProfile(
    Map<String, String> body,
    List<MultipartBody>? multipartBody,
  ) async {
    return await apiClient.postMultipartData(
      AppConstants.updateProfileUri,
      body,
      multipartBody,
    );
  }
}