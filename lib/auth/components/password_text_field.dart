import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.label,
    required this.hintText,
  });

  final String label;
  final String hintText;

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
            fontSize: 16,
            color: AppColors.primaryTextColor,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: TextField(
            cursorColor: AppColors.secondaryTextColor,
            obscureText: isSecure,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.hintTextColor,
                  fontSize: 13,
                ),
                filled: true,
                fillColor: AppColors.backgroundTextField,
                suffixIcon: GestureDetector(
                  child: SvgPicture.asset(
                    "assets/images/eye_icon.svg",
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  onTap: () {
                    setState(() {
                      isSecure = !isSecure;
                    });
                  },
                )),
          ),
        )
      ],
    );
  }
}
