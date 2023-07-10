import 'dart:io';

import 'package:shoes_shop_app/model/address.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class AddressService {
  Future<Address> addAddress(Address address) async {
    Address addressResponse = Address();
    var response = await ClientService().post("/api/v1/address", {
      "addressName": address.addressName,
      "addressDetail": address.addressDetail,
      "selected": address.selected,
    });

    if (response == null) return Address();

    if (response.statusCode == HttpStatus.created) {
      final responseData = response.data["data"];
      addressResponse = Address.fromJson(responseData);
    }
    return addressResponse;
  }

  Future<Address> updateAddress(Address address) async {
    Address addressResponse = Address();
    var response = await ClientService().put("/api/v1/address/${address.id}", {
      "addressName": address.addressName,
      "addressDetail": address.addressDetail,
      "selected": address.selected,
    });

    if (response == null) return Address();

    if (response.statusCode == HttpStatus.created) {
      final responseData = response.data["data"];
      addressResponse = Address.fromJson(responseData);
    }
    return addressResponse;
  }

  Future<List<Address>> getListAddress() async {
    List<Address> listAddress = [];
    var response = await ClientService().get("/api/v1/address");

    if (response == null) return [];

    if (response.statusCode == HttpStatus.ok) {
      final responseData = response.data["data"];
      for (var item in responseData) {
        Address address = Address.fromJson(item);
        listAddress.add(address);
      }
    }
    return listAddress;
  }
}
