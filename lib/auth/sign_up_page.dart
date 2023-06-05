import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoes_shop_app/auth/components/auth_button.dart';
import 'package:shoes_shop_app/auth/components/auth_footer_component.dart';
import 'package:shoes_shop_app/auth/components/email_text_field.dart';
import 'package:shoes_shop_app/auth/components/formal_text_field.dart';
import 'package:shoes_shop_app/auth/components/google_button.dart';
import 'package:shoes_shop_app/auth/components/password_text_field.dart';
import 'package:shoes_shop_app/auth/components/welcome_string.dart';
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
                    AuthButton(
                      title: "Sign Up",
                      onPressed: () {},
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
    );
  }
}
