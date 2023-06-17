import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_shop_app/components/unauthorize_dialog.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/views/auth/login_page.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (_) => authController.isNeedShowDialog()
          ? Container(
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
              child: Center(
                  child: UnAuthorizeDialog(
                subject: "The login session is expired",
                message: "Please, go to login page and login again!",
                iconPath: "assets/images/warning-outline.svg",
                color: AppColors.warningColor,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              )),
            )
          : Container(),
    );
  }
}
