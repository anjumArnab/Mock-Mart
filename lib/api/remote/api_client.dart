import 'dart:convert';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mock_mart/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    if (kDebugMode) {
      print('Token: $token');
    }
    updateHeader(token, sharedPreferences.getString(AppConstants.languageCode));
  }

  void updateHeader(String? token, String? languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Accept-Language': languageCode ?? AppConstants.defaultLanguageCode,
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        print('===== API Call: $uri\nHeader: $_mainHeaders =====');
      }
      
      Uri apiUri = Uri.parse(appBaseUrl + uri);
      if (query != null) {
        apiUri = apiUri.replace(queryParameters: query);
      }

      http.Response response = await http.get(
        apiUri,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if (kDebugMode) {
        print('===== API Call: $uri\nHeader: $_mainHeaders =====');
        print('===== Body: ${body.toString()} =====');
      }

      http.Response response = await http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
    String uri,
    Map<String, String> body,
    List<MultipartBody>? multipartBody,
    {Map<String, String>? headers}
  ) async {
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      
      Map<String, String> multipartHeaders = Map.from(headers ?? _mainHeaders);
      multipartHeaders.remove('Content-Type');
      request.headers.addAll(multipartHeaders);

      if (multipartBody != null && multipartBody.isNotEmpty) {
        for (MultipartBody multipart in multipartBody) {
          if (kIsWeb) {
            Uint8List list = await multipart.file.readAsBytes();
            http.MultipartFile part = http.MultipartFile(
              multipart.key,
              multipart.file.readAsBytes().asStream(),
              list.length,
              filename: multipart.file.name,
            );
            request.files.add(part);
          } else {
            File file = File(multipart.file.path);
            request.files.add(http.MultipartFile(
              multipart.key,
              file.readAsBytes().asStream(),
              file.lengthSync(),
              filename: file.path.split('/').last,
            ));
          }
        }
      }

      request.fields.addAll(body);

      if (kDebugMode) {
        print('===== Multipart API Call: $uri =====');
        print('===== Fields: $body =====');
      }

      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      body = response.body;
    }

    Response response0 = Response(
      body: body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request?.headers ?? {},
        method: response.request?.method ?? '',
        url: response.request?.url ?? Uri.parse(''),
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (response0.statusCode != 200 && response0.body != null && response0.body is Map) {
      if (response0.body.containsKey('message')) {
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: response0.body['message'],
        );
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }

    if (kDebugMode) {
      print('===== API Response: [${response0.statusCode}] $uri =====');
      print('===== Response Body: ${response0.body} =====');
    }

    return response0;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}