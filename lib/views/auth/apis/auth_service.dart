import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shoes_shop_app/constant/network.dart';

class AuthService {
  var client = http.Client();
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

  Future<dynamic> signUp(String lastName, String email, String password) async {
    try {
      var url = Uri.http(Network.baseUrl, '/api/v1/auth/register');

      final requestBody = jsonEncode({
        "email": email,
        "password": password,
        "lastName": lastName,
        "role": "USER"
      });

      var response = await client.post(
        url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      return response;
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      var googleResponse = await googleSignIn.signIn();
      if (googleResponse != null) {
        var url = Uri.http(Network.baseUrl, '/api/v1/auth/login-with-google');
        final msg = jsonEncode({
          "email": googleResponse.email,
        });
        var response = await client.post(
          url,
          body: msg,
          headers: {
            'Content-Type': 'application/json',
          },
        );
        return response;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
