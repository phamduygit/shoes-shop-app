import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/promote.dart';
import 'package:shoes_shop_app/views/order/component/promo_card.dart';

class AddPromoPage extends StatefulWidget {
  const AddPromoPage(
      {super.key, required this.listPromote, required this.selectedIndex});

  final int selectedIndex;
  final List<Promote> listPromote;

  @override
  State<AddPromoPage> createState() => _AddPromoPageState();
}

class _AddPromoPageState extends State<AddPromoPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

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
            Navigator.of(context).pop(selectedIndex);
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
                  children: List.generate(
                    widget.listPromote.length,
                    (index) => PromoCard(
                      isSelected: index == selectedIndex,
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      name:
                          "${widget.listPromote[index].title}: special ${(widget.listPromote[index].discountValue * 100).toStringAsFixed(0)}% off",
                      description: widget.listPromote[index].description,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(-1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondBackgroundColor,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Clear",
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              color: AppColors.secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(selectedIndex);
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
