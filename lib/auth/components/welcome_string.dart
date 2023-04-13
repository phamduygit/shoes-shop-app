import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class WelcomString extends StatelessWidget {
  const WelcomString({
    super.key, required this.firstString, required this.secondString,
  });

  final String firstString;
  final String secondString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          firstString,
          style: GoogleFonts.raleway(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          secondString,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.secondaryTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
