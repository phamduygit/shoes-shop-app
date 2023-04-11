import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello Again!",
                      style: GoogleFonts.raleway(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Fill Your Detail Or Continue With\nSocial Media",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppColors.secondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Address",
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 48,
                          child: TextField(
                            cursorColor: AppColors.secondaryTextColor,
                            style: GoogleFonts.poppins(
                              color: AppColors.secondaryTextColor,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14),
                                ),
                              ),
                              hintText: "xyz@gmail.com",
                              hintStyle: GoogleFonts.poppins(
                                color: AppColors.hintTextColor,
                                fontSize: 13,
                              ),
                              filled: true,
                              fillColor: AppColors.backgroundTextField,
                              hoverColor: AppColors.secondaryTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 48,
                          child: TextField(
                            cursorColor: AppColors.secondaryTextColor,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14),
                                ),
                              ),
                              hintText: "Enter your password",
                              hintStyle: GoogleFonts.poppins(
                                color: AppColors.hintTextColor,
                                fontSize: 13,
                              ),
                              filled: true,
                              fillColor: AppColors.backgroundTextField,
                              suffixIcon: SvgPicture.asset(
                                  "assets/images/eye_icon.svg",
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.scaleDown),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    AppColors.secondaryColor.withOpacity(0.1)),
                          ),
                          child: Text(
                            "Recovery Password",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundTextField,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/google_logo.svg"),
                          const SizedBox(width: 16),
                          Text(
                            "Sign In with Google",
                            style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryTextColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New User?",
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) =>
                          AppColors.secondaryColor.withOpacity(0.1)),
                    ),
                    child: Text(
                      "Craete Account",
                      style: GoogleFonts.raleway(
                        fontSize: 16,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
