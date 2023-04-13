import 'package:flutter/material.dart';
import 'package:shoes_shop_app/auth/components/auth_button.dart';
import 'package:shoes_shop_app/auth/components/auth_footer_component.dart';
import 'package:shoes_shop_app/auth/components/email_text_field.dart';
import 'package:shoes_shop_app/auth/components/forgot_password_button.dart';
import 'package:shoes_shop_app/auth/components/google_button.dart';
import 'package:shoes_shop_app/auth/components/password_text_field.dart';
import 'package:shoes_shop_app/auth/forgot_password.dart';
import 'package:shoes_shop_app/auth/sign_up_page.dart';

import 'components/welcome_string.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void onPressRecoveryPassword() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
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
                    const EmailTextField(
                      label: "Email Address",
                      hintText: "xyz@gmail.com",
                    ),
                    const SizedBox(height: 30),
                    const PasswordTextField(
                      label: "Password",
                      hintText: "Enter your password",
                    ),
                    const SizedBox(height: 12),
                    ForgotPasswordButton(
                      title: "Recovery Password",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      title: "Sign In",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 24),
                    GoogleButton(
                      title: "Sign In with Google",
                      onPressed: () {},
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
    );
  }
}
