import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoes_shop_app/components/auth_builder.dart';
import 'package:shoes_shop_app/components/loading_builder.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/controller/loading_controller.dart';
import 'package:shoes_shop_app/model/auth_response.dart';
import 'package:shoes_shop_app/components/email_text_field.dart';
import 'package:shoes_shop_app/components/formal_text_field.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/components/auth_button.dart';
import 'package:shoes_shop_app/model/user.dart';
import 'package:shoes_shop_app/service/user_service.dart';
import 'package:shoes_shop_app/views/profile/apis/profile_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final LoadingController loadingController = Get.find();
  final AuthController authController = Get.find();

  String userAvatar = "";

  Future<void> handlePressEditImageButton() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image.

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);
        loadingController.load();
        final response = await ProfileService().uploadImage(file);
        loadingController.loadingComplete();
        // Login session is expired
        if (response is AuthenticateResponse) {
          if (response.statusCode == HttpStatus.unauthorized) {
            authController.setAuthorize(false);
          }
        }
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
      debugPrint("Error: ${err.toString()}");
      loadingController.loadingComplete();
    }
  }

  Future<void> handlePressUpdateButton() async {
    loadingController.load();
    final User user = User(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneNumberController.text,
        avatar: userAvatar);
    final User userResponse = await UserService().updateUserInfo(user);
    firstNameController.text = userResponse.firstName;
    lastNameController.text = userResponse.lastName;
    phoneNumberController.text = userResponse.phoneNumber;
    emailController.text = userResponse.email;
    setState(() {
      userAvatar = userResponse.avatar;
    });
    authController.setUserInfo(userResponse);
    loadingController.loadingComplete();
  }

  @override
  void initState() {
    super.initState();
    emailController.text = authController.getUserInfo().email;
    firstNameController.text = authController.getUserInfo().firstName;
    lastNameController.text = authController.getUserInfo().lastName;
    phoneNumberController.text = authController.getUserInfo().phoneNumber;
    userAvatar = authController.getUserInfo().avatar;
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
                                  GetBuilder<AuthController>(
                                    builder: (_) => CircleAvatar(
                                      radius: authController.getAuthorize()
                                          ? 60.0
                                          : 60.0,
                                      backgroundImage: userAvatar == ""
                                          ? authController.getAuthorize() &&
                                                  authController
                                                          .getUserInfo()
                                                          .avatar !=
                                                      ""
                                              ? NetworkImage(
                                                  authController
                                                      .getUserInfo()
                                                      .avatar,
                                                )
                                              : const AssetImage(
                                                  "assets/images/anonymous_user_avatar.png",
                                                ) as ImageProvider
                                          : NetworkImage(userAvatar),
                                      backgroundColor: Colors.transparent,
                                    ),
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
                          const SizedBox(height: 20),
                          FormalTextField(
                            label: "First Name",
                            hintText: "Peter",
                            controller: firstNameController,
                          ),
                          const SizedBox(height: 20),
                          FormalTextField(
                            label: "Last Name",
                            hintText: "Haland",
                            controller: lastNameController,
                          ),
                          const SizedBox(height: 20),
                          EmailTextField(
                            label: "Email Address",
                            hintText: "xyz@gmail.com",
                            emailController: emailController,
                            enable: false,
                          ),
                          const SizedBox(height: 20),
                          FormalTextField(
                            label: "Phone number",
                            hintText: "012345678",
                            controller: phoneNumberController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleButton(
                    title: "Update",
                    onPressed: handlePressUpdateButton,
                  )
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
