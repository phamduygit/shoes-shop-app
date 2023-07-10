import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/views/auth/login_page.dart';

class LogoutRow extends StatelessWidget {
  const LogoutRow({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return GetBuilder<AuthController>(
      builder: (_) => InkWell(
        onTap: authController.getUserInfo().email != ""
            ? onTap
            : () => Get.to(const LoginPage()),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            children: [
              Image.asset(
                authController.getAuthorize()
                    ? "assets/images/logout_icon.png"
                    : "assets/images/login_icon.png",
                width: 24,
                height: 24,
                color: authController.getUserInfo().email != "" ? Colors.red : Colors.blue,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                authController.getUserInfo().email != "" ? "Logout" : "Login",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color:
                      authController.getUserInfo().email != "" ? Colors.red : Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
