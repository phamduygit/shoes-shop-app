import 'package:get/get.dart';
import 'package:shoes_shop_app/model/brand.dart';

class BrandController extends GetxController {
  RxInt id = 0.obs;
  RxString name = "All".obs;

  void setBrandController(Brand brand) {
    id.value = brand.id;
    name.value = brand.name;
  }

}
