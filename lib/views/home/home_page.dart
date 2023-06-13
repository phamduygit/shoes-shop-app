import 'package:flutter/material.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/home/components/branch_categories.dart';
import 'package:shoes_shop_app/views/home/components/header_home_page.dart';
import 'package:shoes_shop_app/views/home/components/product_display_list.dart';
import 'package:shoes_shop_app/views/home/components/search_bar.dart';
import 'package:shoes_shop_app/views/home/components/special_offers_card.dart';
import 'package:shoes_shop_app/views/home/components/title_and_button.dart';
import 'package:shoes_shop_app/views/home/most_popular_page.dart';
import 'package:shoes_shop_app/views/home/search_page.dart';
import 'package:shoes_shop_app/views/home/special_offers_page.dart';

import 'components/filter_branches.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderHomePage(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBar(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SerachPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              TitleAndButton(
                title: "Special Offers",
                onPressedSeeAll: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SpecialOffersPage(),
                    ),
                  );
                },
                titleButton: "See All",
              ),
              const SpecialOfferCard(
                  backgroundColor: AppColors.redColorForDiscount,
                  imageUrl:
                      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                  percentDiscount: 25,
                  title: 'Today Special!',
                  description:
                      "Get discount for every \norder, only valid for today"),
              const BranchCategories(),
              TitleAndButton(
                title: "Most Popular",
                onPressedSeeAll: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MostPopularPage(),
                    ),
                  );
                },
                titleButton: "See All",
              ),
              const FilterBranches(
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
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ProductDisplayList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
