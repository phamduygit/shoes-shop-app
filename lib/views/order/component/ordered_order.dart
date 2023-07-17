import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/cart.dart';

class OrderedCard extends StatelessWidget {
  const OrderedCard({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: AppColors.secondBackgroundColor),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                cartItem.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SizedBox(
                          child: Text(
                            cartItem.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Size = ${cartItem.size}",
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "\$${cartItem.price}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondBackgroundColor,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              child: Text(
                                "${cartItem.quantity}",
                                style: GoogleFonts.poppins(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
