import 'dart:io';

import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class FavoriteService {
  Future<Shoes> addAddFavorite(int shoesId) async {
    var response = await ClientService().post(
      "/api/v1/favorite",
      {"shoesId": shoesId},
    );

    if (response == null) return Shoes();

    if (response.statusCode == HttpStatus.created) {
      var shoesData = response.data["shoes"];
      Shoes shoes = Shoes.fromJson(shoesData);
      return shoes;
    }
    return Shoes();
  }

  Future<bool> removeFavorite(int shoesId) async {
    var response = await ClientService().delete(
      "/api/v1/favorite/shoes/$shoesId",
    );

    if (response == null) return false;

    if (response.statusCode == HttpStatus.noContent) {
      return true;
    }

    return false;
  }

  Future<dynamic> getListFavorite(int? pageNumber) async {
    List<Shoes> listShoes = [];
    int totalPages = 0;
    var response = await ClientService().get("/api/v1/favorite?page=$pageNumber");

    if (response == null) return {"list": listShoes, "totalPages": totalPages};

    if (response.statusCode == HttpStatus.ok) {
      var responseData = response.data["data"];
      totalPages = response.data["totalPages"];

      for (var jsonData in responseData) {
        listShoes.add(Shoes.fromJsonFavorite(jsonData));
      }
      return {"list": listShoes, "totalPages": totalPages};
    }
    return {"list": listShoes, "totalPages": totalPages};
  }
}
