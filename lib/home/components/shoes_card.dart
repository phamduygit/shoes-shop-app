import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';


class ShoesCard extends StatelessWidget {
  const ShoesCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.sold,
    required this.price,
  });

  final String imageUrl;
  final String name;
  final double rating;
  final int sold;
  final double price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  splashRadius: 16,
                  onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondaryColor,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/heart_icon.svg",
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.star_rounded),
              const SizedBox(width: 5),
              Text("$rating"),
              const SizedBox(width: 5),
              const Text("|"),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.backgroundTextField),
                child: Text(
                  "$sold sold",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "\$$price",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
