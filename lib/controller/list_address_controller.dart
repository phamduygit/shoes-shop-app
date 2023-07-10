import 'package:get/get.dart';
import 'package:shoes_shop_app/model/address.dart';

class ListAddressController extends GetxController {
  RxList<Address> listAddress = <Address>[].obs;

  void updateList(List<Address> list) {
    listAddress.value = list;
  }

  List<Address> getList() {
    return listAddress;
  }
}
