import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                        radius: 24,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          Text(
                            "Andrew AinSley",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset("assets/images/heart_icon.svg"),
                      onPressed: () {},
                      iconSize: 24,
                      splashRadius: 24,
                    ),
                    IconButton(
                      icon: SvgPicture.asset("assets/images/bell_icon.svg"),
                      onPressed: () {},
                      iconSize: 24,
                      splashRadius: 24,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
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
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Special Offers",
                  style: GoogleFonts.raleway(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("See All"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 180,
            decoration: const BoxDecoration(
                color: AppColors.redColorForDiscount,
                borderRadius: BorderRadius.all(Radius.circular(35))),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: 35,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                    width: 180,
                    height: 180,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  left: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "25%",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Today' Special!",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Get discount for every \norder, only valid for today",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
