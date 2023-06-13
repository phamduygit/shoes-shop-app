import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_shop_app/constant/network.dart';
import 'package:shoes_shop_app/entity/auth_response.dart';
import 'package:shoes_shop_app/service/common_service.dart';

class ProfileService {
  var client = http.Client();
  var dio = Dio();

  Future<dynamic> uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Get access token to local storage
      final String? accessToken = prefs.getString('accessToken');
      if (accessToken != null) {
        var token = await CommonService().isValidToken(accessToken);
        dio.options.headers["authorization"] = "Bearer $token";
        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(file.path, filename: fileName),
        });
        var response = await dio.post(
          "http://${Network.baseUrl}/uploadImage",
          data: formData,
        );

        AuthResponse authReponse = AuthResponse();
        authReponse.statusCode = response.statusCode!;
        authReponse.data = response.data;
        return authReponse;
      }
    } catch (err) {
      if (err is DioException) {
        AuthResponse authReponse = AuthResponse();
        authReponse.statusCode = err.response!.statusCode!;
        authReponse.data = err.response!.data;
        return authReponse;
      } else {
        debugPrint(err.toString());
      }
    }
  }
}
