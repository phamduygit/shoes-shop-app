import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoes_shop_app/component/auth_builder.dart';
import 'package:shoes_shop_app/component/loading_builder.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/controller/loading_controller.dart';
import 'package:shoes_shop_app/entity/auth_response.dart';
import 'package:shoes_shop_app/views/auth/components/email_text_field.dart';
import 'package:shoes_shop_app/views/auth/components/formal_text_field.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/profile/apis/ProfileService.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final LoadingController loadingController = Get.find();
  final AuthController authController = Get.find();

  String userAvatar =
      "https://images.unsplash.com/photo-1566492031773-4f4e44671857?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3087&q=80";

  Future<void> handlePressEditImageButton() async {
    try {
      
      final ImagePicker picker = ImagePicker();
      // Pick an image.

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);
        loadingController.load();
        final AuthResponse response = await ProfileService().uploadImage(file);
        loadingController.loadingComplete();
        if (response.statusCode == HttpStatus.created) {
          setState(() {
            userAvatar = response.data['url'];
          });
        }
        if (response.statusCode == 401) {
          authController.setAuthorize(false);
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Profile",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: IconButton(
              color: AppColors.secondaryColor,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              splashRadius: 24,
              icon: SvgPicture.asset(
                "assets/images/back_icon.svg",
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
            ),
            elevation: 0,
            backgroundColor: AppColors.backgroundColor,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage(userAvatar),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(0),
                                      width: 24,
                                      height: 24,
                                      child: ElevatedButton(
                                        onPressed: handlePressEditImageButton,
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  AppColors.primaryTextColor),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.mode_edit,
                                          size: 18,
                                          textDirection: TextDirection.ltr,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          FormalTextField(
                            label: "Name",
                            hintText: "Peter",
                            controller: nameController,
                          ),
                          const SizedBox(height: 30),
                          EmailTextField(
                            label: "Email Address",
                            hintText: "xyz@gmail.com",
                            emailController: emailController,
                          ),
                          const SizedBox(height: 30),
                          FormalTextField(
                            label: "Phone number",
                            hintText: "012345678",
                            controller: nameController,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        LoadingBuilder(loadingController: loadingController),
        AuthBuilder(authController: authController),
      ],
    );
  }
}
