import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/auth/components/auth_button.dart';
import 'package:shoes_shop_app/auth/components/email_text_field.dart';
import 'package:shoes_shop_app/auth/components/welcome_string.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
                const EmailTextField(
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
                        return Dialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            height: 196,
                            width: 335,
                            child: Column(
                              children: [
                                Container(
                                  height: 44,
                                  width: 44,
                                  decoration: const BoxDecoration(
                                    color: AppColors.buttonColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/images/email_icon.svg",
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Check Your Email",
                                  style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      color: AppColors.primaryTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "We have Send Password Recovery\nCode In Your Email",
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    color: AppColors.secondaryTextColor,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
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
