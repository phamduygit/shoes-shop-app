import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key, required this.title, required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
            title,
            style: GoogleFonts.raleway(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor,
            ),
          )
        ],
      ),
    );
  }
}
