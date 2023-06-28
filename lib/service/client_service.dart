import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/network.dart';

class ClientService {
  var dio = Dio();
  var baseUrl = Network.getBaseUrl();

  ClientService() {
    // Set default configs
    dio.options.baseUrl = Network.getBaseUrl();
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.followRedirects = false;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // Obtain shared preferences.
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          // Get access token to local storage
          final String? accessToken = prefs.getString('accessToken');

          if (accessToken != null) {
            options.headers["authorization"] = "Bearer $accessToken";
          }
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          return handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> post(String path, Object? object) async {
    try {
      final response = await dio.request(
        path,
        data: object,
        options: Options(method: 'POST'),
      );
      return response;
    } on DioException catch (e) {
      if (e.response!.statusCode == HttpStatus.unauthorized) {
        var accessToken = await refreshToken();
        if (accessToken == "") {
          return null;
        }
        return get(path);
      }
      return null;
    }
  }

  Future<dynamic> get(String path) async {
    try {
      Response response = await dio.request(
        path,
        options: Options(method: 'GET'),
      );
      return response;
    } on DioException catch (e) {
      if (e.response!.statusCode == HttpStatus.unauthorized) {
        var accessToken = await refreshToken();
        if (accessToken == "") {
          return null;
        }
        return get(path);
      }
      return null;
    }
  }

  Future<dynamic> put(String path, Object? object) async {
    try {
      final response = await dio.request(
        path,
        data: object,
        options: Options(method: 'PUT'),
      );
      return response;
    } on DioException catch (e) {
      if (e.response!.statusCode == HttpStatus.unauthorized) {
        var accessToken = await refreshToken();
        if (accessToken == "") {
          return null;
        }
        return get(path);
      }
      return null;
    }
  }

  Future<String> refreshToken() async {
    var dioRefreshToken = Dio();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get refresh token
    final String? refreshToken = prefs.getString('refreshToken');

    if (refreshToken == null || refreshToken == "") {
      return "";
    }

    dioRefreshToken.options.headers["authorization"] = "Bearer $refreshToken";

    var response = await dioRefreshToken.post(
      "${Network.baseUrl}/api/v1/auth/refresh-token",
    );

    // Save access token to local storage
    await prefs.setString('accessToken', response.data["accessToken"]);
    // Save refresh token to local storage
    await prefs.setString('refreshToken', response.data["refreshToken"]);

    return response.data["accessToken"] as String;
  }
}
