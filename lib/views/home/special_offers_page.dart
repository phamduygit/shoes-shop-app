import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/home/components/special_offers_card.dart';

class SpecialOffersPage extends StatelessWidget {
  const SpecialOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Special Offers",
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w700,
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
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SpecialOfferCard(
                backgroundColor: AppColors.redColorForDiscount,
                imageUrl:
                    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                percentDiscount: 25,
                title: 'Today Special!',
                description:
                    "Get discount for every \norder, only valid for today",
              ),
              SpecialOfferCard(
                backgroundColor: Color(0xFFedbeea),
                imageUrl:
                    'https://images.unsplash.com/photo-1605408499391-6368c628ef42?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
                percentDiscount: 25,
                title: 'Weekends Deals',
                description:
                    "Get discount for every \norder, only valid for today",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
