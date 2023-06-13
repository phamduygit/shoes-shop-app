import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/views/cart/active_page.dart';
import 'package:shoes_shop_app/views/cart/complete_page.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/home/search_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int tabIndex = 0;
  int orders = 5;

  @override
  void initState() {
    super.initState();
    tabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(
            "My Cart",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SerachPage(),
                  ),
                );
              },
              icon: Image.asset("assets/images/magnifying_icon.png"),
              splashRadius: 24,
            ),
          ],
          bottom: TabBar(
            indicatorColor: AppColors.secondaryColor,
            indicatorWeight: 3,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
            unselectedLabelColor: Colors.black,
            splashBorderRadius: const BorderRadius.all(Radius.circular(20)),
            onTap: (value) {
              setState(() {
                tabIndex = value;
              });
            },
            tabs: [
              Tab(
                child: Text(
                  "Active",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: tabIndex == 0
                        ? AppColors.secondaryColor
                        : AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Complete",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: tabIndex == 1
                        ? AppColors.secondaryColor
                        : AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
        ),
        body: TabBarView(
          children: [
            ActivePage(orders: orders),
            const CompletePage(),
          ],
        ),
      ),
    );
  }
}
