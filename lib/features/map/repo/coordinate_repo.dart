import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mock_mart/api/remote/api_client.dart';
import 'package:mock_mart/utils/app_constants.dart';

class CoordinateRepo {
  final ApiClient apiClient;

  CoordinateRepo({required this.apiClient});

  Future<Response> getBranches() async {
    Response response = await apiClient.getData(AppConstants.configUri);

    if (response.statusCode == 200 &&
        response.body != null &&
        response.body is Map &&
        response.body.containsKey('branches')) {
      return Response(
        statusCode: 200,
        body: response.body['branches'],
      );
    }

    return Response(
      statusCode: response.statusCode,
      statusText: response.statusText ?? 'Failed to fetch branches',
    );
  }
}
