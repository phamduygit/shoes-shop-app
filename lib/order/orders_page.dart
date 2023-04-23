import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/home/search_page.dart';
import 'package:shoes_shop_app/order/component/footer_order.dart';
import 'package:shoes_shop_app/order/component/order_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    OrderCard(),
                    OrderCard(),
                    OrderCard(),
                    OrderCard(),
                    OrderCard(),
                    OrderCard(),
                    OrderCard(),
                  ],
                ),
              ),
            ),
            const FooterOrder()
          ],
        ),
      ),
    );
  }
}


