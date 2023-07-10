import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/brand.dart';
import 'package:shoes_shop_app/views/home/branch_detail_page.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.brand,
  });

  final Brand brand;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BranchDetailPage(
                  title: brand.name,
                  id: brand.id,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: AppColors.backgroundTextField, shape: BoxShape.circle),
            // TO DO: Change to png
            child: SvgPicture.network(
              brand.image,
              width: 32,
              height: 32,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          brand.name,
          style: GoogleFonts.poppins(fontSize: 14),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
