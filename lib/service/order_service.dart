import 'dart:io';

import 'package:shoes_shop_app/model/order.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class OrderService {
  Future<dynamic> createOrder(int cartId, String shippingAddress,
      String paymentMethod, String shippingMethod) async {
    var response = await ClientService().post("/api/v1/order", {
      "cartId": cartId,
      "address": shippingAddress,
      "paymentMethod": paymentMethod,
      "shippingMethod": "NORMAL"
    });

    if (response.statusCode == HttpStatus.created) {
      return response;
    }

    return null;
  }

  Future<dynamic> getOrder(bool complete, int? page) async {
    String path = "/api/v1/order?isCompleted=$complete";
    if (page != null && page > 0) {
      path += "&pageNumber=$page";
    }
    var response =
        await ClientService().get(path);
    List<Order> listOrder = [];
    int totalPages = 0;

    if (response.statusCode == HttpStatus.ok) {
      var data = response.data;
      var list = data["list"];
      totalPages = data["totalPages"];
      for (var order in list) {
        listOrder.add(Order.fromJson(order));
      }
      return {"list": listOrder, "totalPages": totalPages};
    }

    return {"list": listOrder, "totalPages": totalPages};
  }
}
