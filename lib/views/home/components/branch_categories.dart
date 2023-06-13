import 'package:flutter/material.dart';
import 'package:shoes_shop_app/views/home/components/branch_card.dart';

class BranchCategories extends StatelessWidget {
  const BranchCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 4,
        childAspectRatio: 2 / 3,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          BranchCard(
            filePathToImage: "assets/images/nike_icon.svg",
            name: "Nike",
          ),
          BranchCard(
            filePathToImage: "assets/images/adidas_icon.svg",
            name: "Adidas",
          ),
          BranchCard(
            filePathToImage: "assets/images/puma_icon.svg",
            name: "Puma",
          ),
          BranchCard(
            filePathToImage: "assets/images/asics_icon.svg",
            name: "Asics",
          ),
          BranchCard(
            filePathToImage: "assets/images/reebok_icon.svg",
            name: "Reebok",
          ),
          BranchCard(
            filePathToImage: "assets/images/new_balance_icon.svg",
            name: "New",
          ),
          BranchCard(
            filePathToImage: "assets/images/converse_icon.svg",
            name: "Converse",
          ),
          BranchCard(
            filePathToImage: "assets/images/more_icon.svg",
            name: "More",
          ),
        ],
      ),
    );
  }
}