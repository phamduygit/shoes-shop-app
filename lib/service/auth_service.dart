import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shoes_shop_app/service/client_service.dart';

class AuthService {
  var client = http.Client();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<dynamic> signIn(String email, dynamic password) async {
    try {
      var response = await ClientService().post("/api/v1/auth/login", {
        "email": email,
        "password": password,
      });
      return response;
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  Future<dynamic> signUp(String lastName, String email, String password) async {
    try {
      var response = await ClientService().post("/api/v1/auth/login", {
        "email": email,
        "password": password,
        "lastName": lastName,
        "role": "USER"
      });
      return response;
    } catch (err) {
      debugPrint("Error: $err");
    }
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      var googleResponse = await googleSignIn.signIn();
      if (googleResponse != null) {
        var response =
            await ClientService().post("/api/v1/auth/login-with-google", {
          "email": googleResponse.email,
        });
        return response;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
