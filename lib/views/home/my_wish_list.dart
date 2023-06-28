import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/views/home/components/filter_branches.dart';
import 'package:shoes_shop_app/views/home/components/product_display_list.dart';

class MyWishList extends StatelessWidget {
  const MyWishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Wishlist",
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrow_icon.svg"),
          onPressed: () {Navigator.of(context).pop(true);},
          splashRadius: 24,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: const [
            FilterBranches(
              selectedItemName: "All",
              branchCategories: [
                "All",
                "Nike",
                "Adidas",
                " Puma",
                "Asics",
                "Reebok",
                "New balance",
                "Converse"
              ],
            ),
            // Expanded(
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            //     child: SingleChildScrollView(child: ProductDisplayList()),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
