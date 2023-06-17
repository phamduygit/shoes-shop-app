import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class FormalTextField extends StatelessWidget {
  const FormalTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.raleway(
            fontSize: 14,
            color: AppColors.primaryTextColor,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: TextField(
            controller: controller,
            cursorColor: AppColors.secondaryTextColor,
            style: GoogleFonts.poppins(
              color: AppColors.secondaryTextColor,
              fontSize: 14,
            ),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: AppColors.hintTextColor,
                fontSize: 14,
              ),
              filled: true,
              fillColor: AppColors.backgroundTextField,
              hoverColor: AppColors.secondaryTextColor,
            ),
          ),
        )
      ],
    );
  }
}
