import 'dart:io';

class Network {
  Network._();
  static const baseUrl = "http://localhost:8080";
  static const baseUrlAndroid = "http://10.0.2.2:8080";

  static String getBaseUrl() {
    if (Platform.isAndroid) {
      return baseUrlAndroid;
    } 
    return baseUrl;
  }
}
