import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/service/auth_service.dart';
import 'package:shoes_shop_app/service/client_service.dart';
import 'package:shoes_shop_app/service/user_service.dart';
import 'package:shoes_shop_app/components/auth_button.dart';
import 'package:shoes_shop_app/views/auth/components/auth_footer_component.dart';
import 'package:shoes_shop_app/components/email_text_field.dart';
import 'package:shoes_shop_app/views/auth/components/forgot_password_button.dart';
import 'package:shoes_shop_app/views/auth/components/google_button.dart';
import 'package:shoes_shop_app/components/password_text_field.dart';
import 'package:shoes_shop_app/views/auth/forgot_password.dart';
import 'package:shoes_shop_app/views/auth/sign_up_page.dart';
import 'package:shoes_shop_app/views/auth/utils/validate.dart';
import 'package:shoes_shop_app/constant/colors.dart';

import 'components/auth_dialog.dart';
import 'components/welcome_string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void onPressRecoveryPassword() {}
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController authController = Get.find();

  Future<void> authenticate(dynamic response) async {
    if (response == null) return;

    if (response.statusCode == HttpStatus.ok) {
      var data = response.data;

      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Save access token to local storage
      await prefs.setString('accessToken', data["accessToken"]);

      // Save refresh token to local storage
      await prefs.setString('refreshToken', data["refreshToken"]);

      final validTokenResponse = await ClientService().isValidToken();

      if (response != null) {
        authController.setAuthorize(validTokenResponse.data["valid"]);
      }

      final userResponse = await UserService().getUserInfo();

      if (userResponse != null) {
        authController.setUserInfo(userResponse);
      }
      if (context.mounted) {
        Navigator.of(context).pop(true);
      }
    } else {
      var data = jsonDecode(response.body);

      debugPrint('successful: $data');

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (buildContext) {
            return AuthDialog(
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

  Future<dynamic> singIn({required BuildContext buildContext}) async {
    var validateResult = AuthValidate().validateSignInForm(
      emailController.text,
      passwordController.text,
    );

    if (validateResult != null) {
      // debugPrint(validateResult);
      showDialog(
        context: context,
        builder: (context) {
          return AuthDialog(
            subject: validateResult['subject'],
            message: validateResult['message'],
            iconPath: 'assets/images/warning-outline.svg',
            color: AppColors.warningColor,
          );
        },
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    var response = await AuthService().signIn(
      emailController.text,
      passwordController.text,
    );

    await authenticate(response);

    setState(() {
      isLoading = false;
    });
  }

  Future<dynamic> signInWithGoolge() async {
    setState(() {
      isLoading = true;
    });
    var response = await AuthService().signInWithGoogle();

    await authenticate(response);

    setState(() {
      isLoading = false;
    });
    return;
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
                authController.setShowingDialog(false);
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
                          firstString: "Hello Again!",
                          secondString:
                              "Fill Your Detail Or Continue With\nSocial Media",
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
                        const SizedBox(height: 12),
                        ForgotPasswordButton(
                          title: "Recovery Password",
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        SingleButton(
                          title: "Sign In",
                          onPressed: () async {
                            singIn(buildContext: context);
                          },
                        ),
                        const SizedBox(height: 24),
                        GoogleButton(
                          title: "Sign In with Google",
                          onPressed: () async {
                            await signInWithGoolge();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    AuthFooterComponent(
                      firstString: "New User?",
                      secondString: "Create Account",
                      onPressed: () {
                        debugPrint("Do something!");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
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
