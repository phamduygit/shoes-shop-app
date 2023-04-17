import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleAndSeeAllButton extends StatelessWidget {
  const TitleAndSeeAllButton({
    super.key,
    required this.title,
    required this.onPressedSeeAll,
  });
  final String title;
  final VoidCallback onPressedSeeAll;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: onPressedSeeAll,
            child: const Text("See All"),
          ),
        ],
      ),
    );
  }
}
