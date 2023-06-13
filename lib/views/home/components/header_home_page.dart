import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/views/home/my_wish_list.dart';
import 'package:shoes_shop_app/views/home/notification_page.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                  radius: 24,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    Text(
                      "Andrew AinSley",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: SvgPicture.asset("assets/images/heart_icon.svg"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyWishList(),
                    ),
                  );
                },
                iconSize: 24,
                splashRadius: 24,
              ),
              IconButton(
                icon: SvgPicture.asset("assets/images/bell_icon.svg"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Notificationpage(),
                    ),
                  );
                },
                iconSize: 24,
                splashRadius: 24,
              ),
            ],
          )
        ],
      ),
    );
  }
}
