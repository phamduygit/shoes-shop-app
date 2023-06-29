import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class ShoesService {
  Future<dynamic> filterListShoes(int page) async {
    List<Shoes> listShoes = [];

    var response = await ClientService().get("/api/v1/shoes/all?page=$page");

    if (response.statusCode == HttpStatus.ok) {
      final responseData = response.data["data"]["data"];
      for (var shoes in responseData) {
        listShoes.add(Shoes.fromJson(shoes));
      }
    }
    return {
      'totalPages': response.data["totalPages"],
      'listShoes': listShoes,
    };
  }

  Future<dynamic> getAllShoes() async {
    List<Shoes> listShoes = [];

    var response = await ClientService().get("/api/v1/shoes/all");

    if (response.statusCode == HttpStatus.ok) {
      final responseData = response.data["data"]["data"];
      for (var shoes in responseData) {
        listShoes.add(Shoes.fromJson(shoes));
      }
    }
    return {
      'totalPages': response.data["totalPages"],
      'listShoes': listShoes,
    };
  }
}
