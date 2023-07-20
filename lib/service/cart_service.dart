import 'dart:io';

import 'package:shoes_shop_app/model/cart.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class CartService {
  Future<dynamic> getCarts(int? page) async {
    List<CartItem> listCartItem = [];
    int totalPages = 0;
    double totalPrice = 0;
    String path = "/api/v1/cart";
    if (page != null) path = "/api/v1/cart?pageNumber=$page";
    var response = await ClientService().get(path);
    if (response == null) {
      return {
        "list": listCartItem,
        "totalPages": totalPages,
        "totalPrice": totalPrice,
      };
    }

    if (response.statusCode == HttpStatus.ok) {
      var listItem = response.data["data"]["list"];
      totalPages = response.data["data"]["totalPages"];
      totalPrice = response.data["totalPrice"];

      for (var item in listItem) {
        listCartItem.add(CartItem.fromJson(item));
      }

      return {
        "list": listCartItem,
        "totalPages": totalPages,
        "totalPrice": totalPrice,
      };
    }
    return {
      "list": listCartItem,
      "totalPages": totalPages,
      "totalPrice": totalPrice,
    };
  }

  Future<dynamic> getAllCartItem() async {
    List<CartItem> listCartItem = [];
    double totalPrice = 0;
    int cartId = 0;

    var response = await ClientService().get("/api/v1/cart/all");
    if (response == null) return listCartItem;

    if (response.statusCode == HttpStatus.ok) {
      var listItem = response.data["data"]["list"];
      totalPrice = response.data["totalPrice"];
      cartId = response.data["cartId"];

      for (var item in listItem) {
        listCartItem.add(CartItem.fromJson(item));
      }
      return {"list": listCartItem, "totalPrice": totalPrice, "cartId": cartId};
    }

    return {"list": listCartItem, "totalPrice": totalPrice, "cartId": cartId};
  }

  Future<CartItem> addShoesToCart(
    int shoesId,
    int quantity,
    String size,
  ) async {
    CartItem cartItem = CartItem();
    var response = await ClientService().post("/api/v1/cart", {
      "shoesId": shoesId,
      "quantity": quantity,
      "size": size,
    });

    if (response == null) return CartItem();

    if (response.statusCode == HttpStatus.created) {
      var resposneData = response.data;
      cartItem = CartItem.fromJson(resposneData);
    }

    return cartItem;
  }

  Future<CartItem> updateQuantity(
    int cartId,
    int quantity,
    int size,
  ) async {
    CartItem cartItem = CartItem();
    var response = await ClientService().put("/api/v1/cart/$cartId", {
      "quantity": quantity,
      "size": size,
    });

    if (response == null) return CartItem();

    if (response.statusCode == HttpStatus.ok) {
      var resposneData = response.data;
      cartItem = CartItem.fromJson(resposneData);
    }

    return cartItem;
  }

  Future<bool> deleteCartItem(int cartId) async {
    var response = await ClientService().delete("/api/v1/cart/$cartId");
    if (response.statusCode == HttpStatus.noContent) {
      return true;
    }
    return false;
  }
}
