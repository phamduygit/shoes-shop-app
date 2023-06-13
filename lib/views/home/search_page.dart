import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/home/components/filter_branches.dart';
import 'package:shoes_shop_app/views/home/components/title_and_button.dart';
import 'package:shoes_shop_app/views/home/search_result_page.dart';

class SerachPage extends StatelessWidget {
  const SerachPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
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
              const Expanded(child: BoderSideSearchBar()),
            ],
          ),
          TitleAndButton(
              title: "Recent",
              onPressedSeeAll: () {},
              titleButton: "Clear All"),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 1,
              color: AppColors.secondaryTextColor,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                  SearchResultRow(
                    text: 'Nike Wrapshot Classic',
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class SearchResultRow extends StatelessWidget {
  const SearchResultRow({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SearchResultpage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 15, color: AppColors.secondaryTextColor),
            ),
            IconButton(
              onPressed: () {},
              splashRadius: 20,
              icon: SvgPicture.asset(
                "assets/images/borderd_close_icon.svg",
                colorFilter: const ColorFilter.mode(
                  AppColors.secondaryTextColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoderSideSearchBar extends StatelessWidget {
  const BoderSideSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        onTap: () {},
        cursorColor: AppColors.secondaryTextColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor, width: 0.0),
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
            ),
          ),
          hintText: "Search",
          hintStyle: GoogleFonts.poppins(
            color: AppColors.hintTextColor,
            fontSize: 13,
          ),
          filled: true,
          fillColor: AppColors.backgroundTextField,
          suffixIcon: GestureDetector(
            child: SvgPicture.asset(
              "assets/images/filter_icon.svg",
              width: 5,
              height: 5,
              fit: BoxFit.none,
              // colorFilter: const ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
            ),
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const ShortAndFilterSheet();
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

class ShortAndFilterSheet extends StatelessWidget {
  const ShortAndFilterSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Column(
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
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Gender",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const FilterBranches(
                      selectedItemName: "All",
                      branchCategories: ["All", "Men", "Women"],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Price Range",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomRangeSlider(),
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
                    const FilterBranches(
                      selectedItemName: "Popular",
                      branchCategories: [
                        "Popular",
                        "Most Recent",
                        "Price High",
                        "Price Low",
                      ],
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
                    const FilterBranches(
                      selectedItemName: "★ All",
                      branchCategories: [
                        "★ All",
                        "★ 5",
                        "★ 4",
                        "★ 3",
                        "★ 2",
                        "★ 1",
                      ],
                    ),
                  ],
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
                      onPressed: () {},
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
                      onPressed: () {},
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
    );
  }
}

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({
    super.key,
  });

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  double startval = 0, endval = 100;
  @override
  Widget build(BuildContext context) {
    RangeLabels labels = RangeLabels(startval.toString(), endval.toString());
    return RangeSlider(
        max: 1000,
        min: 0,
        values: RangeValues(startval, endval),
        labels: labels,
        divisions: 10,
        onChanged: (RangeValues value) {
          setState(() {
            startval = value.start;
            endval = value.end;
          });
        },
        activeColor: AppColors.secondaryColor,
        inactiveColor: AppColors.secondBackgroundColor);
  }
}
