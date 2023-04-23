import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:shoes_shop_app/constant/colors.dart";
import "package:shoes_shop_app/order/component/shipping_option_card.dart";

class ChoseShippingPage extends StatelessWidget {
  const ChoseShippingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Choose Shipping",
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
                    ShippingOptionCard(
                      name: "Home",
                      description: "61480 Sunbrook Park, PC 5679",
                      isSelected: true,
                      onPressed: () {},
                      iconUri: "assets/images/economy_icon.png",
                      price: "\$10",
                    ),
                    ShippingOptionCard(
                      name: "Office",
                      description: "6993 Meadow Valley Terra, PC 3637",
                      isSelected: false,
                      onPressed: () {},
                      iconUri: "assets/images/regular_icon.png",
                      price: "\$15",
                    ),
                    ShippingOptionCard(
                      name: "Apartment",
                      description: "21833 Cly Gallagher, PC 4662",
                      isSelected: false,
                      onPressed: () {},
                      iconUri: "assets/images/truck_icon.png",
                      price: "\$20",
                    ),
                    ShippingOptionCard(
                      name: "Parent's House",
                      description: "5259 Blue Bill Park, PC 4627",
                      isSelected: false,
                      onPressed: () {},
                      iconUri: "assets/images/express_icon.png",
                      price: "\$30",
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
