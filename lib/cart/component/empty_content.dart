import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/no_data.png",
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 12),
          Text(
            "You don't have an order yet",
            style: GoogleFonts.raleway(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "You don't have an active orders at this time",
            style: GoogleFonts.raleway(fontSize: 14),
          )
        ],
      ),
    );
  }
}