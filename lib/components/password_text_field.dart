import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.label,
    required this.hintText, required this.passwordController,
  });

  final String label;
  final String hintText;
  final TextEditingController passwordController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.raleway(
            fontSize: 14,
            color: AppColors.primaryTextColor,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: TextField(
            controller: widget.passwordController,
            cursorColor: AppColors.secondaryTextColor,
            obscureText: isSecure,
            style: GoogleFonts.poppins(
              color: AppColors.secondaryTextColor,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.poppins(
                color: AppColors.hintTextColor,
                fontSize: 14,
              ),
              filled: true,
              fillColor: AppColors.backgroundTextField,
              hoverColor: AppColors.secondaryTextColor,
              suffixIcon: Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Image.asset(
                    isSecure
                        ? "assets/images/eye-off-outline.png"
                        : "assets/images/eye-outline.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  onTap: () {
                    setState(() {
                      isSecure = !isSecure;
                    });
                  },
                ),
              ),
              suffixIconConstraints: const BoxConstraints(
                minHeight: 28,
                minWidth: 28,
              ),
              
            ),
          ),
        )
      ],
    );
  }
}
