import 'package:flutter/material.dart';
import 'package:shoes_shop_app/model/brand.dart';
import 'package:shoes_shop_app/views/home/components/branch_card.dart';

class BrandCategory extends StatelessWidget {
  const BrandCategory({super.key, required this.listBrand});

  final List<Brand> listBrand;

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
        children: List.generate(listBrand.length, (index) {
          return BranchCard(
            brand: listBrand[index],
          );
        }),
      ),
    );
  }
}
