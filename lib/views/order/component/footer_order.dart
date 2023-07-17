import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/order/checkout_page.dart';

class FooterOrder extends StatelessWidget {
  const FooterOrder({
    super.key,
    required this.totalPrice,
  });

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.primaryColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total price",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CheckoutPage(),
                  ),
                );
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
                    "Checkout",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Image.asset(
                    "assets/images/arrow_right_icon.png",
                    width: 16,
                    height: 16,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
