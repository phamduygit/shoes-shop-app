import 'package:get/get.dart';

class IndexNavigationController extends GetxController {
  RxInt index = 0.obs;

  void setIndex(int index) {
    this.index.value = index;
  }
}
