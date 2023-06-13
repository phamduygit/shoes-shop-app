import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/colors.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => AppColors.secondaryColor.withOpacity(0.1)),
          ),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.secondaryTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
