import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoes_shop_app/constant/network.dart';

class AuthService {
  var client = http.Client();

  Future<dynamic> signIn(String email, dynamic password) async {
    try {
      var url = Uri.http(Network.baseUrl, '/api/v1/auth/login');
      final msg = jsonEncode({
        "email": email,
        "password": password,
      });
      var response = await client.post(
        url,
        body: msg,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      debugPrint('error: $e');
    }
  }
}
