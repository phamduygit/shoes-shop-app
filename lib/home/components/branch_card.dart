import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.filePathToImage,
    required this.name,
  });

  final String filePathToImage;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              color: AppColors.backgroundTextField, shape: BoxShape.circle),
          child: SvgPicture.asset(
            filePathToImage,
            width: 32,
            height: 32,
          ),
        ),
        const SizedBox(height: 20),
        Text(name, style: GoogleFonts.poppins(fontSize: 14))
      ],
    );
  }
}