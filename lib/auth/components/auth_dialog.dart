import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';


class AuthDialog extends StatelessWidget {
  const AuthDialog({
    super.key,
    required this.subject,
    required this.message,
    required this.iconPath,
    required this.color,
  });

  final String subject;
  final String message;
  final String iconPath;
  final Color color;
  @override
  Widget build(BuildContext context) {
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
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  iconPath,
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              subject,
              style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: AppColors.primaryTextColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
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
  }
}