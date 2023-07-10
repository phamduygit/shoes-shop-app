import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/views/home/components/search_bar.dart';
import 'package:shoes_shop_app/views/home/search_page.dart';

class SearchResultpage extends StatelessWidget {
  const SearchResultpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: SvgPicture.asset("assets/images/arrow_icon.svg"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  splashRadius: 24,
                ),
                const SizedBox(width: 10),
                Expanded(child: SearchBar(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SerachPage(),
                      ),
                    );
                  },
                )),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Result for "Running"',
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "0 found",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // const Expanded(
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            //     child: SingleChildScrollView(
            //       child: ProductDisplayList(),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
