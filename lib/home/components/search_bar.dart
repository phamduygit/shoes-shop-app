import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: TextField(
        cursorColor: AppColors.secondaryTextColor,
        decoration: InputDecoration(
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
            child: SvgPicture.asset(
              "assets/images/magnifying_icon.svg",
              width: 5,
              height: 5,
              fit: BoxFit.scaleDown,
              colorFilter: const ColorFilter.mode(
                  AppColors.secondaryTextColor, BlendMode.srcIn),
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}