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
        return post(path, object);
      }

      if (e.response!.statusCode == HttpStatus.badRequest) {
        return e.response;
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
        return put(path, object);
      }
      return null;
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await dio.request(
        path,
        options: Options(method: 'DELETE'),
      );
      return response;
    } on DioException catch (e) {
      if (e.response!.statusCode == HttpStatus.unauthorized) {
        var accessToken = await refreshToken();
        if (accessToken == "") {
          return null;
        }
        return delete(path);
      }
      return null;
    }
  }

  Future<String> refreshToken() async {
    try {
      var dioRefreshToken = Dio();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isAvailableRefreshToken = prefs.getBool('isAvailableRefreshToken');
      if (isAvailableRefreshToken != null && isAvailableRefreshToken == false) {
        return "accessToken";
      }
      await prefs.setBool('isAvailableRefreshToken', false);
      // Get refresh token
      final String? refreshToken = prefs.getString('refreshToken');

      if (refreshToken == null || refreshToken == "") {
        // Save refresh token to local storage
        await prefs.setBool('isAvailableRefreshToken', true);
        return "";
      }

      dioRefreshToken.options.headers["authorization"] = "Bearer $refreshToken";

      String url = "${Network.getBaseUrl()}/api/v1/auth/refresh-token";

      var response = await dioRefreshToken.post(
        url,
      );

      // Save access token to local storage
      await prefs.setString('accessToken', response.data["accessToken"]);
      // Save refresh token to local storage
      await prefs.setString('refreshToken', response.data["refreshToken"]);
      // Save refresh token to local storage
      await prefs.setBool('isAvailableRefreshToken', true);
      return response.data["accessToken"] as String;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 401) {
        // do something
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Save refresh token to local storage
      await prefs.setBool('isAvailableRefreshToken', true);
      return "";
    }
  }
}
