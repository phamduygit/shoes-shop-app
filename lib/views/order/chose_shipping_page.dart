import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/order/component/shipping_option_card.dart';

class ChoseShippingPage extends StatefulWidget {
  const ChoseShippingPage({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<ChoseShippingPage> createState() => _ChoseShippingPageState();
}

class _ChoseShippingPageState extends State<ChoseShippingPage> {
  int selectedMethod = 0;

  @override
  void initState() {
    selectedMethod = widget.selectedIndex;
    super.initState();
  }

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
            Navigator.of(context).pop(selectedMethod);
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
                      name: "Normal",
                      description: "From 5 - 7 days from order date",
                      isSelected: selectedMethod == 0,
                      onPressed: () {
                        setState(() {
                          selectedMethod = 0;
                        });
                      },
                      iconUri: "assets/images/economy_icon.png",
                      price: "\$10",
                    ),
                    ShippingOptionCard(
                      name: "Fast",
                      description: "From 3 - 4 days from order date",
                      isSelected: selectedMethod == 1,
                      onPressed: () {
                        setState(() {
                          selectedMethod = 1;
                        });
                      },
                      iconUri: "assets/images/regular_icon.png",
                      price: "\$15",
                    ),
                    ShippingOptionCard(
                      name: "Express",
                      description: "From 1 - 2 days from order date",
                      isSelected: selectedMethod == 2,
                      onPressed: () {
                        setState(() {
                          selectedMethod = 2;
                        });
                      },
                      iconUri: "assets/images/truck_icon.png",
                      price: "\$20",
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(selectedMethod);
                      },
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
