import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/controller/brand_controller.dart';
import 'package:shoes_shop_app/model/brand.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/brand_controller.dart';
import 'package:shoes_shop_app/service/shoes_service.dart';
import 'package:shoes_shop_app/views/home/components/filter_branches.dart';
import 'package:shoes_shop_app/views/home/components/product_display_list.dart';

class SerachPage extends StatefulWidget {
  const SerachPage({super.key});

  @override
  State<SerachPage> createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  RxBool isLoading = false.obs;
  RxBool isFetching = false.obs;
  List<Brand> brandList = [];
  RxList<Shoes> shoesList = <Shoes>[].obs;
  List<String> filterdBrandList = ["All"];
  int totalPages = 0;
  int currentPage = 1;
  BrandController selectedBrand = BrandController();
  RxString selectedSortType = "Default".obs;
  final scrollController = ScrollController();
  final textFieldController = TextEditingController();

  void init() async {
    isLoading.value = true;
    brandList = await BrandService().getListBrand();
    filterdBrandList = filterdBrandList + brandList.map((e) => e.name).toList();
    var response = await ShoesService().getAllShoes();
    shoesList.value = response["listShoes"];
    totalPages = response["totalPages"];
    isLoading.value = false;
  }

  void onPressApplyFilter(String brandName, String sortType) async {
    isFetching.value = true;
    selectedSortType.value = sortType;
    if (brandName == "All") {
      selectedBrand.id.value = 0;
      selectedBrand.name.value = "All";
    } else {
      var brand = brandList.firstWhere((element) => element.name == brandName);
      selectedBrand.setBrandController(brand);
    }
    shoesList.value = [];
    // fetch new list
    int price = 0;
    if (sortType == "Price High") {
      price = 1;
    } else if (sortType == "Price Low") {
      price = -1;
    }
    var response = await ShoesService().filterSearchListShoes(
      0,
      selectedBrand.id.value,
      textFieldController.text,
      sortType == "Newest" ? true : false,
      price,
    );
    shoesList.value = response["listShoes"];
    totalPages = response["totalPages"];
    currentPage = 1;
    isFetching.value = false;
  }

  Future<void> fetchMore(int pageKey) async {
    if (pageKey < totalPages) {
      var response =
          await ShoesService().filterListShoes(pageKey, selectedBrand.id.value);
      shoesList.value = shoesList.toList() +  response["listShoes"];
      currentPage = currentPage + 1;
    }
  }

  void onChangeTextField() async {
    debugPrint(textFieldController.text);
    isLoading.value = true;
    selectedBrand.id.value = 0;
    selectedSortType.value = "Default";
    selectedBrand.name.value = "All";
    var response = await ShoesService().filterSearchListShoes(
      0,
      selectedBrand.id.value,
      textFieldController.text,
      false,
      0,
    );
    shoesList.value = response["listShoes"];
    totalPages = response["totalPages"];
    currentPage = 1;
    isLoading.value = false;
  }

  @override
  void initState() {
    init();
    textFieldController.text = '';
    textFieldController.addListener(onChangeTextField);
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
      body: Obx(
        () => SafeArea(
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
                  Expanded(
                    child: BoderSideSearchBar(
                      listBrand: filterdBrandList,
                      onPressApply: onPressApplyFilter,
                      selectedBrand: selectedBrand.name.value,
                      selectedSortType: selectedSortType.value,
                      textController: textFieldController,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                child: Row(
                  children: [
                    Chip(
                      label: Text("Brand: ${selectedBrand.name}"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 2,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      label: Text("Sort: ${selectedSortType.value}"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 2,
                      ),
                    ),
                  ],
                ),
              ),
              isLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.red,
                        size: 48,
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
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
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class BoderSideSearchBar extends StatelessWidget {
  const BoderSideSearchBar({
    super.key,
    required this.listBrand,
    required this.onPressApply,
    required this.selectedBrand,
    required this.selectedSortType,
    required this.textController,
  });

  final List<String> listBrand;
  final Function(String, String) onPressApply;
  final String selectedBrand;
  final String selectedSortType;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 12),
      child: TextField(
        onTap: () {},
        controller: textController,
        cursorColor: AppColors.secondaryTextColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
            borderSide: BorderSide.none,
          ),
          hintText: "Search",
          hintStyle: GoogleFonts.poppins(
            color: AppColors.hintTextColor,
            fontSize: 13,
          ),
          filled: true,
          fillColor: AppColors.backgroundTextField,
          suffixIcon: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                "assets/images/filter_icon.svg",
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                // colorFilter: const ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
              ),
            ),
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return ShortAndFilterSheet(
                    listBrand: listBrand,
                    onPressApply: onPressApply,
                    selectedBrand: selectedBrand,
                    selectedSortType: selectedSortType,
                  );
                },
              );
            },
          ),
          prefixIcon: GestureDetector(
            child: Image.asset(
              "assets/images/magnifying_icon.png",
              width: 5,
              height: 5,
              fit: BoxFit.scaleDown,
              color: AppColors.secondaryTextColor,
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class ShortAndFilterSheet extends StatefulWidget {
  const ShortAndFilterSheet({
    super.key,
    required this.listBrand,
    required this.onPressApply,
    required this.selectedBrand,
    required this.selectedSortType,
  });

  final List<String> listBrand;
  final Function(String, String) onPressApply;
  final String selectedBrand;
  final String selectedSortType;

  @override
  State<ShortAndFilterSheet> createState() => _ShortAndFilterSheetState();
}

class _ShortAndFilterSheetState extends State<ShortAndFilterSheet> {
  RxString selectedBrand = "All".obs;
  RxString selectedSortType = "Default".obs;

  void onPressFilterBrand(String value) {
    selectedBrand.value = value;
  }

  void onPressSortType(String value) {
    selectedSortType.value = value;
  }

  @override
  void initState() {
    selectedBrand.value = widget.selectedBrand;
    selectedSortType.value = widget.selectedSortType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.primaryColor,
        ),
        height: MediaQuery.of(context).size.height * 0.75,
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Sort & Filter",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Divider(
                  color: AppColors.secondaryTextColor,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Categories",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        FilterBranches(
                          selectedItemName: selectedBrand.value,
                          branchCategories: widget.listBrand,
                          onPressed: onPressFilterBrand,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Sort by",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        FilterBranches(
                          selectedItemName: selectedSortType.value,
                          branchCategories: const [
                            "Default",
                            "Newest",
                            "Price High",
                            "Price Low",
                          ],
                          onPressed: onPressSortType,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          selectedBrand.value = "All";
                          selectedSortType.value = "Default";
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.resetButtonBackgroundColor,
                          foregroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Reset",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onPressApply(
                            selectedBrand.value,
                            selectedSortType.value,
                          );
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          foregroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Apply",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
