import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class ShoesService {
  Future<dynamic> filterListShoes(int page, int brandId) async {
    List<Shoes> listShoes = [];

    String path = "/api/v1/shoes/all?page=$page&brandId=$brandId";
    if (brandId == 0) {
      path = "/api/v1/shoes/all?page=$page";
    }
    var response = await ClientService().get(path);

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

  Future<dynamic> filterSearchListShoes(
    int page,
    int brandId,
    String name,
    bool newest,
    int price,
  ) async {
    List<Shoes> listShoes = [];
    String path = "/api/v1/shoes/all?page=$page&name=$name";
    if (brandId != 0) {
      path += '&brandId=$brandId';
    }
    if (newest == true) {
      path += '&newest=$newest';
    }
    if (price != 0) {
      path += '&price=$price';
    }
    var response = await ClientService().get(path);

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

  Future<dynamic> getAllShoesByBrandId(int brandId, int page) async {
    List<Shoes> listShoes = [];

    var response =
        await ClientService().get("/api/v1/shoes?brandId=$brandId&page=$page");

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

    if (response == null) {
      return;
    }

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

  Future<Shoes?> getShoesDetail(int id) async {
    var response = await ClientService().get("/api/v1/shoes/$id");
    if (response.statusCode == HttpStatus.ok) {
      return Shoes.fromJsonDetail(response.data);
    }
    return null;
  }
}
