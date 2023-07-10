import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/controller/brand_controller.dart';
import 'package:shoes_shop_app/model/brand.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/brand_controller.dart';
import 'package:shoes_shop_app/service/shoes_service.dart';
import 'package:shoes_shop_app/views/home/components/product_display_list.dart';

import 'components/filter_branches.dart';

class MostPopularPage extends StatefulWidget {
  const MostPopularPage({super.key});

  @override
  State<MostPopularPage> createState() => _MostPopularPageState();
}

class _MostPopularPageState extends State<MostPopularPage> {
  RxBool isLoading = false.obs;
  RxBool isFetching = false.obs;
  List<Brand> brandList = [];
  List<Shoes> shoesList = [];
  List<String> filterdBrandList = ["All"];
  int totalPages = 0;
  int currentPage = 1;
  BrandController selectedBrand = BrandController();
  final scrollController = ScrollController();

  void init() async {
    isLoading.value = true;
    brandList = await BrandService().getListBrand();
    filterdBrandList = filterdBrandList + brandList.map((e) => e.name).toList();
    var response = await ShoesService().getAllShoes();
    shoesList = response["listShoes"];
    totalPages = response["totalPages"];
    isLoading.value = false;
  }

  void onPressFilterBrand(String value) async {
    isFetching.value = true;
    if (value == "All") {
      selectedBrand.id.value = 0;
      selectedBrand.name.value = "";
    } else {
      var brand = brandList.firstWhere((element) => element.name == value);
      selectedBrand.setBrandController(brand);
    }

    // fetch new list
    var response =
        await ShoesService().filterListShoes(0, selectedBrand.id.value);
    shoesList = response["listShoes"];
    totalPages = response["totalPages"];
    currentPage = 1;
    isFetching.value = false;
  }

  Future<void> fetchMore(int pageKey) async {
    if (pageKey < totalPages) {
      var response =
          await ShoesService().filterListShoes(pageKey, selectedBrand.id.value);
      shoesList = shoesList + response["listShoes"];
      currentPage = currentPage + 1;
    }
  }

  @override
  void initState() {
    init();
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        isFetching.value = true;
        await fetchMore(currentPage);
        await Future.delayed(const Duration(seconds: 1));
        isFetching.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Most popular",
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
        elevation: 0,
      ),
      body: Obx(
        () => isLoading.value
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.red,
                  size: 48,
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      FilterBranches(
                        selectedItemName: selectedBrand.name.value,
                        branchCategories: filterdBrandList,
                        onPressed: onPressFilterBrand,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: ProductDisplayList(shoes: shoesList),
                      ),
                      isFetching.value
                          ? Column(
                              children: [
                                const SizedBox(height: 20),
                                LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.red,
                                  size: 48,
                                ),
                              ],
                            )
                          : Container(),
                      isFetching.value
                          ? Container()
                          : const SizedBox(height: 68),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
