import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/auth/components/auth_button.dart';
import 'package:shoes_shop_app/auth/components/email_text_field.dart';
import 'package:shoes_shop_app/auth/components/welcome_string.dart';
import 'package:shoes_shop_app/constant/colors.dart';

import 'components/auth_dialog.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const WelcomString(
                  firstString: "Forgot Password",
                  secondString:
                      "Fill Your Email Account To Reset\nYour Password",
                ),
                const SizedBox(height: 30),
                EmailTextField(
                  emailController: myController,
                  label: "Email Address",
                  hintText: "xyz@gmail.com",
                ),
                const SizedBox(height: 40),
                AuthButton(
                  title: "Reset Password",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AuthDialog(
                          subject: "Check Your Email",
                          message:
                              "We have Send Password Recovery\nCode In Your Email",
                          iconPath: "assets/images/email_icon.svg",
                          color: AppColors.buttonColor,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


