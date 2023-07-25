import 'dart:io';

class Network {
  Network._();
  static const baseUrl = "http://localhost:8080";
  static const baseUrlAndroid = "http://10.0.2.2:8080";
  static const productionUrl =
      "http://ec2-54-151-180-18.ap-southeast-1.compute.amazonaws.com";

  static String getBaseUrl() {
    if (Platform.isAndroid) {
      return baseUrlAndroid;
    }
    return baseUrl;
    // return productionUrl;
  }
}
