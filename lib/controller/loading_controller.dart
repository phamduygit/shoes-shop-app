import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false;

  void load() {
    isLoading = true;
    update();
  }

  void loadingComplete() {
    isLoading = false;
    update();
  }

  bool getLoadingState() {
    return isLoading;
  }
}
