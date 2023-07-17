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

  Future<List<Shoes>> getListFavorite() async {
    List<Shoes> listShoes = [];
    var response = await ClientService().get("/api/v1/favorite");

    if (response == null) return [];

    if (response.statusCode == HttpStatus.ok) {
      var responseData = response.data["data"];
      for (var jsonData in responseData) {
        listShoes.add(Shoes.fromJsonFavorite(jsonData));
      }
      return listShoes;
    }
    return [];
  }
}
