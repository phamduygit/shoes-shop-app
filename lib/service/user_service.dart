import 'package:dio/dio.dart';
import 'package:shoes_shop_app/constant/network.dart';
import 'package:shoes_shop_app/entity/user.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class UserService {
  var dio = Dio();
  var baseUrl = Network.getBaseUrl();

  Future<dynamic> getUserInfo() async {
    var response = await ClientService().getWithAuthorize("/api/v1/user");
    if (response != null) {
      var data = response.data;
      User user = User(
          firstName: data["firstName"] ?? "",
          lastName: data["lastName"] ?? "",
          avatar: data["avatar"] ?? "",
          phoneNumber: data["phoneNumber"] ?? "",
          email: data["email"] ?? "");
      return user;
    }
    return User();
  }

  Future<dynamic> updateUserInfo(User user) async {
    var response = await ClientService().putWithAuthorize("/api/v1/user", {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "avatar": user.avatar,
      "phoneNumber": user.phoneNumber
    });

    if (response != null) {
      var data = response.data;
      User updatedUser = User(
          firstName: data["firstName"] ?? "",
          lastName: data["lastName"] ?? "",
          avatar: data["avatar"] ?? "",
          phoneNumber: data["phoneNumber"] ?? "",
          email: data["email"] ?? "");
      return updatedUser;
    }
    return User();
  }
}
