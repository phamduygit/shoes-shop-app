import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shoes_shop_app/entity/user.dart';

class AuthController extends GetxController {
  var authorize = false;
  var isShowingDialog = false;
  var user = User();

  void setAuthorize(bool isAuthor) {
    authorize = isAuthor;
    isShowingDialog = !isAuthor;
    update();
  }

  void setShowingDialog(bool show) {
    isShowingDialog = show;
    update();
  }

  bool isNeedShowDialog() {
    return isShowingDialog;
  }

  bool getAuthorize() {
    return authorize;
  }

  void setUserInfo(User user) {
    this.user = user;
    update();
  }

  User getUserInfo() {
    return user;
  }
}
