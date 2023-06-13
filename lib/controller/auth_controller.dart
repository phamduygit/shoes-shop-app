import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shoes_shop_app/entity/auth_response.dart';
import 'package:shoes_shop_app/service/common_service.dart';

class AuthController extends GetxController {
  var authorize = true;

  var dio = Dio();

  Future<void> setAuthorize(bool isAuthor) async {
    if (isAuthor == false) {
      try {
        AuthResponse authReponse = await CommonService().refreshToken();
        if (authReponse.statusCode == HttpStatus.ok) {
          authorize = true;
        } else {
          authorize = isAuthor;
        }
      } catch (err) {
        debugPrint(err.toString());
        authorize = false;
      }
    }
    update();
  }

  bool isNotAuthorize() {
    return !authorize;
  }
}
