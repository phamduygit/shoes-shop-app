import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/model/user.dart';
import 'package:shoes_shop_app/views/auth/login_page.dart';
import 'package:shoes_shop_app/views/profile/address_page.dart';
import 'package:shoes_shop_app/views/profile/components/logout_row.dart';
import 'package:shoes_shop_app/views/profile/components/setting_row.dart';
import 'package:shoes_shop_app/views/profile/edit_profile_page.dart';

import '../../constant/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void onPressEditProfileRow() {
    Get.to(
      const EditProfilePage(),
    );
  }

  void onPressAddressRow() {
    Get.to(
      const AddressPage(),
    );
  }

  Future<void> onPressLogoutRow() async {
    // Clear access token and refresh token
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove accessToken key
    await prefs.remove('accessToken');

    // Remove refreshToken key
    await prefs.remove('refreshToken');

    final AuthController authController = Get.find();

    authController.setAuthorize(false);

    authController.setUserInfo(User());

    // Go to login page
    Get.to(
      const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        GetBuilder<AuthController>(
                          builder: (_) => CircleAvatar(
                            radius: authController.getAuthorize() ? 60.0 : 60.0,
                            backgroundImage:
                                authController.getUserInfo().avatar != ""
                                    ? NetworkImage(
                                        authController.getUserInfo().avatar,
                                      )
                                    : const AssetImage(
                                        "assets/images/anonymous_user_avatar.png",
                                      ) as ImageProvider,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GetBuilder<AuthController>(
                          builder: (_) => Text(
                            (authController.getUserInfo().firstName != "" ||
                                    authController.getUserInfo().lastName != "")
                                ? "${authController.getUserInfo().firstName} ${authController.getUserInfo().lastName}"
                                : "Anonymous",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GetBuilder<AuthController>(
                          builder: (_) => Text(
                            (authController.getUserInfo().phoneNumber != "")
                                ? authController.getUserInfo().phoneNumber
                                : "Empty",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      children: [
                        SettingRow(
                          startIcon: "assets/images/person_icon.png",
                          name: "Edit Profile",
                          onTap: onPressEditProfileRow,
                        ),
                        SettingRow(
                          startIcon: "assets/images/address_icon.png",
                          name: "Address",
                          onTap: onPressAddressRow,
                        ),
                        SettingRow(
                          startIcon: "assets/images/notification_icon.png",
                          name: "Notification",
                          onTap: onPressEditProfileRow,
                        ),
                        SettingRow(
                          startIcon: "assets/images/payment_icon.png",
                          name: "Payment",
                          onTap: onPressEditProfileRow,
                        ),
                        SettingRow(
                          startIcon: "assets/images/security_icon.png",
                          name: "Security",
                          onTap: onPressEditProfileRow,
                        ),
                        SettingRow(
                          startIcon: "assets/images/help_icon.png",
                          name: "Help center",
                          onTap: onPressEditProfileRow,
                        ),
                        SettingRow(
                          startIcon: "assets/images/share_icon.png",
                          name: "Invite friend",
                          onTap: onPressEditProfileRow,
                        ),
                        LogoutRow(
                          onTap: onPressLogoutRow,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
