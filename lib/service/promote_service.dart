import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_app/model/promote.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class PromoteService {
  Future<List<Promote>?> getAllPromote() async {
    try {
      List<Promote> listPromote = [];
      Response response = await ClientService().get("/api/v1/promote");
      if (response.data != null) {
        for (var promoteData in response.data["data"]) {
          listPromote.add(Promote.fromJson(promoteData));
        }
        return listPromote;
      }
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
