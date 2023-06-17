import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_shop_app/entity/auth_response.dart';

import '../constant/network.dart';

class ClientService {
  var dio = Dio();
  var baseUrl = Network.getBaseUrl();

  Future<dynamic> post(String path, Object? object) async {
    // Update path
    String url = baseUrl + path;
    Response response = await dio.post(url, data: object);
    return response;
  }

  Future<dynamic> postWithAuthorize(String path, Object? object) async {
    try {
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
    } catch (err) {
      if (err is DioException) {
        if (err.response!.statusCode == HttpStatus.unauthorized) {
          await refreshToken();
          return postWithAuthorize(path, object);
        }
      }
    }
  }

  Future<dynamic> get(String path) async {
    // Update path
    String url = baseUrl + path;
    Response response = await dio.get(url);
    return response;
  }

  Future<dynamic> getWithAuthorize(String path) async {
    try {
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get access token to local storage
      final String? accessToken = prefs.getString('accessToken');
      // Update path
      String url = baseUrl + path;

      if (accessToken != null) {
        dio.options.headers["authorization"] = "Bearer $accessToken";
        Response response = await dio.get(url);
        return response;
      }
    } catch (err) {
      if (err is DioException) {
        if (err.response!.statusCode == HttpStatus.unauthorized) {
          await refreshToken();
          return getWithAuthorize(path);
        }
      }
    }
  }

  Future<dynamic> put(String path, Object? object) async {
    // Update path
    String url = baseUrl + path;
    Response response = await dio.put(url, data: object);
    return response;
  }
  
  Future<dynamic> putWithAuthorize(String path, Object? object) async {
    try {
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get access token to local storage
      final String? accessToken = prefs.getString('accessToken');
      // Update path
      String url = baseUrl + path;

      if (accessToken != null) {
        dio.options.headers["authorization"] = "Bearer $accessToken";
        Response response = await dio.put(url, data: object);
        return response;
      }
    } catch (err) {
      if (err is DioException) {
        if (err.response!.statusCode == HttpStatus.unauthorized) {
          await refreshToken();
          return postWithAuthorize(path, object);
        }
      }
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

  Future<dynamic> isValidToken() async {
    var resposne = await getWithAuthorize("/api/v1/user/check-token");
    return resposne;
  }
}