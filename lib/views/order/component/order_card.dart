import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/components/quantity.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    this.isDiableRemove,
  });

  final bool? isDiableRemove;
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
            child: Image.asset(
              "assets/images/shoes/shoes2.png",
              fit: BoxFit.cover,
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
                  SizedBox(height: (isDiableRemove == true) ? 12 : 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SizedBox(
                          child: Text(
                            "Air Jordan 3 Retro",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      isDiableRemove == true
                          ? Container()
                          : IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const RemoveFromCartSheet();
                                  },
                                );
                              },
                              icon: Image.asset(
                                "assets/images/trash_icon.png",
                                height: 18,
                                width: 18,
                              ),
                              splashRadius: 18,
                            ),
                    ],
                  ),
                  SizedBox(height: (isDiableRemove == true) ? 12 : 0),
                  Text(
                    "Size = 42",
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "\$105.00",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      const QuantityWidget(),
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

class RemoveFromCartSheet extends StatelessWidget {
  const RemoveFromCartSheet({
    super.key,
  });

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
            const OrderCard(isDiableRemove: true),
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
                      onPressed: () {},
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
                      onPressed: () {},
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
