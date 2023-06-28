import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/model/brand.dart';
import 'package:shoes_shop_app/model/promote.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/model/user.dart';
import 'package:shoes_shop_app/service/home_service.dart';
import 'package:shoes_shop_app/service/user_service.dart';
import 'package:shoes_shop_app/utils/string_covert.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.find();
  List<Brand> brandData = [];
  Promote promote = Promote(startDate: DateTime.now(), endDate: DateTime.now());
  List<Shoes> shoesData = [];
  RxBool isLoading = false.obs;

  Future<void> init() async {
    isLoading.value = false;
    List response = await Future.wait([
      HomeService().getFirstPromote(),
      HomeService().getAllBrand(),
      HomeService().getAllShoes(),
      UserService().getUserInfo(),
    ]);
    promote = response[0] as Promote;
    brandData = response[1] as List<Brand>;
    shoesData = response[2] as List<Shoes>;
    authController.setUserInfo(response[3]);
    isLoading.value = true;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: isLoading.value
              ? SingleChildScrollView(
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
                      SpecialOfferCard(
                        backgroundColor:
                            StringConvert().hexStringToColor(promote.color),
                        imageUrl: promote.coverImage,
                        percentDiscount: (promote.discountValue) * 100,
                        title: promote.title,
                        description: promote.description,
                      ),
                      BrandCategory(
                        listBrand: brandData,
                      ),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: ProductDisplayList(
                          shoes: shoesData,
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.red,
                  size: 48,
                )),
        ),
      ),
    );
  }
}
