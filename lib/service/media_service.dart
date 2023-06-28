import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_shop_app/model/auth_response.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class MediaService {
  var dio = ClientService();
  Future<dynamic> uploadFile(File file) async {
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

    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    var response = await dio.post('/uploadImage', formData);
    return response;
  }
}
