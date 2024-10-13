import 'dart:convert';
import 'package:fashion_flow/core/api/http/responseModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  final int timeoutInSeconds = 30;
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;

  String? token;
  late Map<String, String> mainHeaders;

  HttpService(this.appBaseUrl, this.sharedPreferences) {
    // debugPrint('Token: $token');
    updateHeaders(
      token,
    );
  }

  void updateHeaders(String? token) {
    mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Connection': "keep-alive"
      // 'Authorization': 'Bearer $token',
    };
  }

  Future<ResponseModel> _performRequest(
    String uri,
    Future<http.Response> Function() requestFunction,
  ) async {
    try {
      final response = await requestFunction();

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) {
          return ResponseModel(data: "Done", isSuccess: true);
        }
        final ResponseModel res =
            ResponseModel(data: json.decode(response.body), isSuccess: true);
        http.Client().close();
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');

        return res;
      } else {
        debugPrint(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
        return ResponseModel(
          isSuccess: false,
          data: null,
          errorMessage: json.decode(response.body)['msg'],
        );
      }
    } catch (error) {
      debugPrint('====> API Error: $error');
      return ResponseModel(
          isSuccess: false, data: null, errorMessage: '$error');
    }
  }

  Future<ResponseModel> getData({
    required String uri,
    Map<String, String>? headers,
  }) async {
    return _performRequest('$appBaseUrl$uri', () async {
      return http.get(Uri.parse('$appBaseUrl$uri'),
          headers: headers ?? mainHeaders);
    });
  }

  Future<ResponseModel> postData({
    required String uri,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    debugPrint('====> API Call: $uri\nHeader: $mainHeaders');
    debugPrint('====> API Body: $body');

    return _performRequest('$appBaseUrl$uri', () async {
      return http.post(
        Uri.parse('$appBaseUrl$uri'),
        headers: headers ?? mainHeaders,
        body: jsonEncode(body),
      );
    });
  }

  Future<ResponseModel> postMultipartData({
    required String uri,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) async {
    return _performRequest('$appBaseUrl$uri', () async {
      return http.post(
        Uri.parse('$appBaseUrl$uri'),
        headers: headers ?? mainHeaders,
        body: body,
      );
    });
  }

  Future<ResponseModel> putData({
    required String uri,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    return _performRequest('$appBaseUrl$uri', () async {
      return http.put(
        Uri.parse('$appBaseUrl$uri'),
        headers: headers ?? mainHeaders,
        body: json.encode(body),
      );
    });
  }

  Future<ResponseModel> deleteData({
    required String uri,
    Map<String, String>? headers,
  }) async {
    return _performRequest('$appBaseUrl$uri', () async {
      return http.delete(Uri.parse('$appBaseUrl$uri'),
          headers: headers ?? mainHeaders);
    });
  }
}
