import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/order.dart';
import 'package:shoes_shop_app/views/cart/track_order_page.dart';

class TrackedOrderCard extends StatelessWidget {
  const TrackedOrderCard({
    super.key,
    required this.order,
  });
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                order.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SizedBox(
                          child: Text(
                            order.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                  Text(
                    "Size = ${order.size}  |  Qty = ${order.quantity}",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: AppColors.secondaryTextColor),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.secondBackgroundColor),
                    child: Text(
                      order.shippingStatus,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "\$${order.price}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.secondaryColor),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TrackOrderPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Tracker order",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
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
