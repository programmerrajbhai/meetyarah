import 'dart:convert';

import 'package:http/http.dart';

class networkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic data;
  final String? errorMessage;

  networkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    this.errorMessage,
  });

}

class networkClient {
  static Future<networkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri);

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return networkResponse(
          isSuccess: true,
          data: decodedJson,
          statusCode: response.statusCode,
        );
      } else {
        return networkResponse(
          isSuccess: false,
          errorMessage: "Something went wrong!",
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return networkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }

  static Future<networkResponse> postRequest({
    required String url,
    required Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return networkResponse(
          isSuccess: true,
          data: decodedJson,
          statusCode: response.statusCode,
        );
      } else {
        return networkResponse(
          isSuccess: false,
          errorMessage: "Something went wrong!",
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return networkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }
}
