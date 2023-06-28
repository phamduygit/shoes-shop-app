import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/views/home/components/product_display_list.dart';
import 'package:shoes_shop_app/views/home/search_page.dart';

class BranchDetailPage extends StatelessWidget {
  const BranchDetailPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrow_icon.svg"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          splashRadius: 24,
        ),
        actions: [
          IconButton(
            icon: Image.asset("assets/images/magnifying_icon.png"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SerachPage(),
                ),
              );
            },
            splashRadius: 24,
          ),
        ],
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          // child: ProductDisplayList(),
        ),
      ),
    );
  }
}
