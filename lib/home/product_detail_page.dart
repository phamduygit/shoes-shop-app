import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

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
      body: SafeArea(
        child: Column(
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
                      child: Image.asset(
                        "assets/images/shoes/shoes1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Air JorDan 3 Retro",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                    "assets/images/heart_icon.svg"),
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
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.backgroundTextField),
                                child: Text(
                                  "1234 sold",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.star_rounded),
                              const SizedBox(width: 5),
                              const Text("4.9 (6.573 reviews)"),
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
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
                          const SizeSelection(
                            categories: ["38", "39", "40", "41", "42"],
                            selectedItemName: "40",
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
    );
  }
}

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
  });

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: AppColors.secondBackgroundColor,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                count = count - 1;
              });
            },
            icon: Image.asset(
              "assets/images/subtract_icon.png",
              height: 18,
              width: 18,
            ),
            splashRadius: 12,
          ),
          SizedBox(
            width: 20,
            child: Text(
              "$count",
              style: GoogleFonts.poppins(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                count = count + 1;
              });
            },
            icon: Image.asset(
              "assets/images/plus_icon.png",
              height: 18,
              width: 18,
            ),
            splashRadius: 12,
          ),
        ],
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
