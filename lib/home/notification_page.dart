import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class Notificationpage extends StatelessWidget {
  const Notificationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Notification",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TitlePromotion(
                title: 'Today',
              ),
              SizedBox(height: 12),
              PromoteCard(
                image: "assets/images/discount_icon.svg",
                title: "30% Special Discount!",
                description: "Special promotion only valid today",
              ),
              SizedBox(height: 12),
              TitlePromotion(
                title: 'Yesterday',
              ),
              PromoteCard(
                image: "assets/images/wallet_icon_1.svg",
                title: "Top Up E-Wallet Successful!",
                description: "New Services Available!",
              ),
              PromoteCard(
                image: "assets/images/location_icon.svg",
                title: "New Services Available!",
                description: "Now you can trach orders in real time",
              ),
              SizedBox(height: 12),
              TitlePromotion(
                title: 'December 22, 2024',
              ),
              PromoteCard(
                image: "assets/images/card_icon.svg",
                title: "Credit Card Connected!",
                description: "Credit Card has been linked!",
              ),
              PromoteCard(
                image: "assets/images/user_icon.svg",
                title: "Account Setup SuccessFull",
                description: "Your account has been created!",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitlePromotion extends StatelessWidget {
  const TitlePromotion({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PromoteCard extends StatelessWidget {
  const PromoteCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Card(
        elevation: 2,
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondaryColor,
                ),
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: SvgPicture.asset(
                    image,
                    fit: BoxFit.fill,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
