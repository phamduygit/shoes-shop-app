import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextField(
        enabled: false,
        cursorColor: AppColors.secondaryTextColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          hintText: "Search",
          hintStyle: GoogleFonts.poppins(
            color: AppColors.hintTextColor,
            fontSize: 13,
          ),
          filled: true,
          fillColor: AppColors.backgroundTextField,
          suffixIcon: GestureDetector(
            child: SvgPicture.asset(
              "assets/images/filter_icon.svg",
              width: 5,
              height: 5,
              fit: BoxFit.none,
              // colorFilter: const ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
            ),
            onTap: () {},
          ),
          prefixIcon: GestureDetector(
            child: Image.asset(
              "assets/images/magnifying_icon.png",
              width: 5,
              height: 5,
              fit: BoxFit.scaleDown,
              color: AppColors.secondaryTextColor,
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
