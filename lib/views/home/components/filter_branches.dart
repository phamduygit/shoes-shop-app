import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class FilterBranches extends StatelessWidget {
  const FilterBranches({
    super.key,
    required this.branchCategories,
    required this.selectedItemName,
    required this.onPressed,
  });

  final List<String> branchCategories;
  final String selectedItemName;
  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: branchCategories
            .map(
              (e) => FilterItem(
                name: e,
                isSelected: e == selectedItemName,
                onPressed: () {
                  onPressed(e);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem({
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
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
          color: isSelected ? AppColors.secondaryColor : AppColors.primaryColor,
        ),
        child: Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w600,
            color:
                isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
