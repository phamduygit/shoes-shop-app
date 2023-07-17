import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/cart.dart';
import 'package:shoes_shop_app/views/order/component/order_card.dart';

class RemoveFromCartSheet extends StatelessWidget {
  const RemoveFromCartSheet({
    super.key,
    required this.cartItem,
    required this.onPressDelete,
  });

  final CartItem cartItem;
  final Function(int) onPressDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.backgroundColor,
      ),
      height: 350,
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Text(
                "Remove From Cart?",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(
                color: AppColors.secondaryTextColor,
              ),
            ),
            OrderCard(
              isDiableRemove: true,
              cartItem: cartItem,
              onPressDelete: (int value) {},
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(
                color: AppColors.secondaryTextColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onPressDelete(cartItem.id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Yes, Remove",
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}