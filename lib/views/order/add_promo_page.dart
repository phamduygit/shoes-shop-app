import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/order/component/promo_card.dart';

class AddPromoPage extends StatelessWidget {
  const AddPromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Order",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrow_icon.svg"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          splashRadius: 24,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    PromoCard(
                      name: "Special 25% off",
                      description: "Special promo only today!",
                      isSelected: true,
                      onPressed: () {},
                    ),
                    PromoCard(
                      name: "Special 30% off",
                      description: "Special promo only today!",
                      isSelected: false,
                      onPressed: () {},
                    ),
                    PromoCard(
                      name: "Special 20% off",
                      description: "Special promo only today!",
                      isSelected: false,
                      onPressed: () {},
                    ),
                    PromoCard(
                      name: "Special 40% off",
                      description: "Special promo only today!",
                      isSelected: false,
                      onPressed: () {},
                    ),
                    PromoCard(
                      name: "Special 35% off",
                      description: "Special promo only today!",
                      isSelected: false,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Apply",
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}