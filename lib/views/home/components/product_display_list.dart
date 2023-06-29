import 'package:flutter/material.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/views/home/components/shoes_card.dart';

class ProductDisplayList extends StatelessWidget {
  const ProductDisplayList({
    super.key,
    required this.shoes,
  });

  final List<Shoes> shoes;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.64,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        shoes.length,
        (index) => ShoesCard(
          shoes: shoes[index],
        ),
      ),
    );
  }
}
