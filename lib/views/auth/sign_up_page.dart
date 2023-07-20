import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/service/auth_service.dart';
import 'package:shoes_shop_app/components/auth_button.dart';
import 'package:shoes_shop_app/views/auth/components/confirm_dialog.dart';
import 'package:shoes_shop_app/views/auth/components/auth_footer_component.dart';
import 'package:shoes_shop_app/components/email_text_field.dart';
import 'package:shoes_shop_app/components/formal_text_field.dart';
import 'package:shoes_shop_app/views/auth/components/google_button.dart';
import 'package:shoes_shop_app/components/password_text_field.dart';
import 'package:shoes_shop_app/views/auth/components/welcome_string.dart';
import 'package:shoes_shop_app/utils/validate.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<dynamic> handleClickSignUpButton() async {
    // Validate all text field
    var validateResult = AuthValidate().validateSignUpForm(
      nameController.text,
      emailController.text,
      passwordController.text,
      confirmPasswordController.text,
    );

    if (validateResult != null) {
      // show progress dialog
      showDialog(
        context: context,
        builder: (context) {
          return ConfirmDialog(
            subject: validateResult['subject'],
            message: validateResult['message'],
            iconPath: 'assets/images/warning-outline.svg',
            color: AppColors.warningColor,
          );
        },
      );
      return;
    }
    // Request register
    setState(() {
      isLoading = true;
    });

    var response = await AuthService().signUp(
      nameController.text,
      emailController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    debugPrint("Response: ${jsonDecode(response.body)}");
    if (response.statusCode == HttpStatus.ok) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (buildContext) {
            return const ConfirmDialog(
              subject: 'Authentication success',
              message: 'Your account have been created',
              iconPath: 'assets/images/checkmark-done-outline.svg',
              color: AppColors.successColor,
            );
          },
        );
      }
    } else if (response.statusCode == HttpStatus.badRequest) {
      var data = response.data;

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (buildContext) {
            return ConfirmDialog(
              subject: 'Authentication failure',
              message: data['message'],
              iconPath: 'assets/images/warning-outline.svg',
              color: AppColors.warningColor,
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
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
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const WelcomString(
                          firstString: "Register Account",
                          secondString:
                              "Fill your details or continue with\nsocial media",
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
                          enable: true,
                        ),
                        const SizedBox(height: 30),
                        PasswordTextField(
                          label: "Password",
                          hintText: "Enter your password",
                          passwordController: passwordController,
                        ),
                        const SizedBox(height: 30),
                        PasswordTextField(
                          label: "Confirm Password",
                          hintText: "Enter again your password",
                          passwordController: confirmPasswordController,
                        ),
                        const SizedBox(height: 40),
                        SingleButton(
                          title: "Sign Up",
                          onPressed: handleClickSignUpButton,
                        ),
                        const SizedBox(height: 24),
                        GoogleButton(
                          title: "Sign Up with Google",
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    AuthFooterComponent(
                      firstString: "Already Have Account?",
                      secondString: "Log In",
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading
            ? Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.red,
                    size: 48,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
