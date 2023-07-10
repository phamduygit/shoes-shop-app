import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';

class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.startIcon,
    required this.name,
    required this.onTap,
  });

  final String startIcon;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return GetBuilder<AuthController>(
      builder: (_) => InkWell(
        onTap: authController.getUserInfo().email != "" ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    startIcon,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              // const Spacer(),
              Image.asset(
                "assets/images/chevron_right.png",
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
