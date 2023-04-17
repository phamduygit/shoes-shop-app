import 'package:flutter/material.dart';
import 'package:shoes_shop_app/home/components/branch_categories.dart';
import 'package:shoes_shop_app/home/components/header_home_page.dart';
import 'package:shoes_shop_app/home/components/product_display_list.dart';
import 'package:shoes_shop_app/home/components/search_bar.dart';
import 'package:shoes_shop_app/home/components/special_offers_card.dart';
import 'package:shoes_shop_app/home/components/title_and_see_all_button.dart';

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
              const SearchBar(),
              const SizedBox(height: 10),
              TitleAndSeeAllButton(
                title: "Special Offers",
                onPressedSeeAll: () {},
              ),
              const SizedBox(height: 10),
              const SpecialOfferCard(),
              const BranchCategories(),
              TitleAndSeeAllButton(
                title: "Most Popular",
                onPressedSeeAll: () {},
              ),
              const FilterBranches(
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
              const ProductDisplayList()
            ],
          ),
        ),
      ),
    );
  }
}



