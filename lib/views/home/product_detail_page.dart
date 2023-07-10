import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/components/quantity.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/shoes_service.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.id});

  final int id;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Shoes shoesData = Shoes();
  RxBool isLoading = false.obs;

  Future<void> init() async {
    isLoading.value = true;
    var response = await ShoesService().getShoesDetail(widget.id);
    if (response != null) {
      shoesData = response;
    }
    isLoading.value = false;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrow_icon.svg"),
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashRadius: 24,
        ),
        backgroundColor: AppColors.secondBackgroundColor,
        elevation: 0,
      ),
      body: Obx(
        () => SafeArea(
          child: isLoading.value
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.red,
                    size: 48,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: AppColors.secondBackgroundColor),
                              child: Image.network(
                                shoesData.coverImage,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          shoesData.name,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                          "assets/images/heart_icon.svg",
                                        ),
                                        splashRadius: 18,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color:
                                                AppColors.backgroundTextField),
                                        child: Text(
                                          "${shoesData.sold} sold",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.star_rounded),
                                      const SizedBox(width: 5),
                                      Text(
                                        "${shoesData.rating} (${shoesData.reviews} reviews)",
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Text(
                                    "Description",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    shoesData.description!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Size",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizeSelection(
                                    categories: shoesData.sizes!,
                                    selectedItemName: shoesData.sizes![0],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Text(
                                        "Quantity",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      const QuantityWidget()
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Divider(),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Total price",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    "\$105.00",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondaryColor,
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/bag_fill_icon.png",
                                        width: 16,
                                        height: 16,
                                        color: AppColors.primaryColor,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        "Add to Cart",
                                        style: GoogleFonts.raleway(
                                          fontSize: 18,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

class SizeSelection extends StatefulWidget {
  const SizeSelection(
      {super.key, required this.selectedItemName, required this.categories});

  final String selectedItemName;
  final List<String> categories;

  @override
  State<SizeSelection> createState() => _SizeSelectionState();
}

class _SizeSelectionState extends State<SizeSelection> {
  late String selectedItemName;
  @override
  void initState() {
    super.initState();
    selectedItemName = widget.selectedItemName;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.categories
            .map(
              (e) => SizeItem(
                name: e,
                isSelected: e == selectedItemName,
                onPressed: () {
                  setState(() {
                    selectedItemName = e;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class SizeItem extends StatelessWidget {
  const SizeItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onPressed,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 1.5),
          color: isSelected ? AppColors.secondaryColor : AppColors.primaryColor,
        ),
        child: Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color:
                isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
