import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/service/media_service.dart';

class ProfileService {
  var dio = Dio();
  final AuthController authController = AuthController();

  Future<dynamic> uploadImage(File file) async {
    try {
      final response = await MediaService().uploadFile(file);
      return response;
    } catch (err) {
      debugPrint(err.toString());
      return err;
    }
  }
}
