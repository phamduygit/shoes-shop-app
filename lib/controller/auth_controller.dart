import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  var authorize = true;

  var dio = Dio();

  void setAuthorize(bool isAuthor) {
    authorize = isAuthor;
    update();
  }

  bool isNotAuthorize() {
    return !authorize;
  }
}
