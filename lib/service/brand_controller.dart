import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:shoes_shop_app/model/brand.dart';
import 'package:shoes_shop_app/service/client_service.dart';

class BrandService {
  Future<List<Brand>> getListBrand() async {
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
}
