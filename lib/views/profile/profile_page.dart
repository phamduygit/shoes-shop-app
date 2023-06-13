import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/views/profile/edit_profile_page.dart';

import '../../constant/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        const CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1566492031773-4f4e44671857?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3087&q=80"),
                          backgroundColor: Colors.transparent,
                        ),
                        Text(
                          "Andrew Ainsley",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "0342569003",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        Get.to(() => const EditProfilePage());
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: SettingRow(
                          startIcon: "assets/images/person_icon.png",
                          name: "Edit Profile",
                        ),
                      ),
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

class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.startIcon,
    required this.name,
  });

  final String startIcon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          startIcon,
          width: 16,
          height: 16,
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 16,
            ),
          ),
        ),
        Image.asset(
          "assets/images/chevron_right.png",
          width: 12,
          height: 18,
        ),
      ],
    );
  }
}
