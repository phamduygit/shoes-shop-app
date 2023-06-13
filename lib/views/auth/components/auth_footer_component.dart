import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class AuthFooterComponent extends StatelessWidget {
  const AuthFooterComponent({
    super.key, required this.firstString, required this.secondString, required this.onPressed,
  });

  final String firstString;
  final String secondString;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstString,
          style: GoogleFonts.raleway(
            fontSize: 16,
            color: AppColors.primaryTextColor,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => AppColors.secondaryColor.withOpacity(0.1)),
          ),
          child: Text(
            secondString,
            style: GoogleFonts.raleway(
              fontSize: 16,
              color: AppColors.primaryTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
