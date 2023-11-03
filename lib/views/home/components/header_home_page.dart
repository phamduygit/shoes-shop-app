import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';

import 'package:shoes_shop_app/views/home/my_wish_list.dart';
import 'package:shoes_shop_app/views/home/notification_page.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    super.key,
  });

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    late AuthController authController = Get.find();
    String greetingString = "Good ${greeting()}";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                GetBuilder<AuthController>(
                  builder: (_) => CircleAvatar(
                    backgroundImage: authController.getUserInfo().avatar != ""
                        ? NetworkImage(
                            authController.getUserInfo().avatar,
                          )
                        : const AssetImage(
                            "assets/images/anonymous_user_avatar.png",
                          ) as ImageProvider,
                    radius: 24,
                    backgroundColor: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greetingString,
                      style: GoogleFonts.poppins(fontSize: 14),
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
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: SvgPicture.asset("assets/images/heart_icon.svg"),
                onPressed: () {
                  if (authController.getUserInfo().email == "") {
                    authController.setAuthorize(false);
                  } else {
                    Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyWishList(),
                    ),
                  );
                  }
                },
                iconSize: 24,
                splashRadius: 24,
              ),
              IconButton(
                icon: SvgPicture.asset("assets/images/bell_icon.svg"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Notificationpage(),
                    ),
                  );
                },
                iconSize: 24,
                splashRadius: 24,
              ),
            ],
          )
        ],
      ),
    );
  }
}
