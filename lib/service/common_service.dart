import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_shop_app/entity/auth_response.dart';

import '../constant/network.dart';

class CommonService {
  var dio = Dio();

  Future<dynamic> refreshToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get refresh token
      final String? refreshToken = prefs.getString('refreshToken');

      dio.options.headers["authorization"] = "Bearer $refreshToken";

      var response = await dio.post(
        "http://${Network.baseUrl}/api/v1/auth/refresh-token",
      );

      // Save access token to local storage
      await prefs.setString('accessToken', response.data["accessToken"]);
      // Save refresh token to local storage
      await prefs.setString('refreshToken', response.data["refreshToken"]);

      AuthResponse authReponse = AuthResponse();
      authReponse.statusCode = response.statusCode!;
      authReponse.data = response.data;
      return authReponse;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  /// Check valid access toke
  /// @params accessToken String
  /// @return String
  Future<dynamic> isValidToken(String accessToken) async {
    try {
      dio.options.headers["authorization"] = "Bearer $accessToken";

      var response = await dio.post(
        "http://${Network.baseUrl}/api/v1/user/check-token",
      );
      return accessToken;
    } catch (err) {
      // AuthResponse authReponse = AuthResponse();
      // authReponse.statusCode = err.response!.statusCode!;
      // authReponse.data = err.response!.data;
      // return authReponse;
      if (err is DioException) {
        if (err.response!.statusCode! == HttpStatus.unauthorized) {
          AuthResponse authResponse = await refreshToken();
          return authResponse.data["accessToken"];
        }
      }
    }
  }
}
