import 'dart:io';

import 'package:shoes_shop_app/model/brand.dart';
import 'package:shoes_shop_app/model/promote.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class HomeService {
  Future<Promote> getFirstPromote() async {
    Promote firstPromote = Promote(
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );

    var response = await ClientService().get("/api/v1/promote");

    if (response.statusCode == HttpStatus.ok) {
      final firstData = response.data["data"].first;
      firstPromote = Promote.fromJson(firstData);
    }

    return firstPromote;
  }

  Future<List<Brand>> getAllBrand() async {
    List<Brand> listBrand = [];

    var response = await ClientService().get("/api/v1/brand-category");

    if (response.statusCode == HttpStatus.ok) {
      final responseList = response.data["data"];
      for (var brand in responseList) {
        listBrand.add(Brand.fromJson(brand));
      }
    }
    return listBrand;
  }

  Future<List<Shoes>> getAllShoes() async {
    List<Shoes> listShoes = [];

    var response = await ClientService().get("/api/v1/shoes/all");

    if (response.statusCode == HttpStatus.ok) {
      final responseData = response.data["data"]["data"];
      for (var shoes in responseData) {
        listShoes.add(Shoes.fromJson(shoes));
      }
    }
    return listShoes;
  }
}
