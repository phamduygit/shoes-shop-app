import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_shop_app/entity/auth_response.dart';

import '../constant/network.dart';

class ClientService {
  var dio = Dio();
  var baseUrl = Network.getBaseUrl();

  Future<dynamic> sendPostRequest(String path, Object? object) async {
    // Update path
    String url = baseUrl + path;
    Response response = await dio.post(url, data: object);
    return response;
  }

  Future<dynamic> sendPostRequstWithAuthorize(
      String path, Object? object) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get access token to local storage
    final String? accessToken = prefs.getString('accessToken');
    // Update path
    String url = baseUrl + path;

    if (accessToken != null) {
      dio.options.headers["authorization"] = "Bearer $accessToken";
      Response response = await dio.post(url, data: object);
      return response;
    }
  }

  Future<dynamic> uploadFile(File file) async {
    try {
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get access token to local storage
      final String accessToken = prefs.getString('accessToken') ?? "";

      if (accessToken == "") {
        final authenResponse = AuthenticateResponse();
        authenResponse.statusCode = HttpStatus.unauthorized;
        authenResponse.message = "Unauthenticate user";
        return authenResponse;
      }
      // Update path
      String url = "$baseUrl/uploadImage";

      String fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      dio.options.headers["authorization"] = "Bearer $accessToken";
      var response = await dio.post(url, data: formData);
      return response;
    } catch (err) {
      if (err is DioException) {
        if (err.response!.statusCode == HttpStatus.unauthorized) {
          await refreshToken();
          return uploadFile(file);
        }
      }
    }
  }

  Future<dynamic> sendGetRequest(String path) async {
    Response response = await dio.get(path);
    return response;
  }

  Future<dynamic> refreshToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get refresh token
      final String? refreshToken = prefs.getString('refreshToken');

      dio.options.headers["authorization"] = "Bearer $refreshToken";

      var response = await dio.post(
        "${Network.baseUrl}/api/v1/auth/refresh-token",
      );

      // Save access token to local storage
      await prefs.setString('accessToken', response.data["accessToken"]);
      // Save refresh token to local storage
      await prefs.setString('refreshToken', response.data["refreshToken"]);
    } catch (e) {
      debugPrint('error: $e');
    }
  }
}
