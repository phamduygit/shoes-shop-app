import 'package:flutter/material.dart';
import 'package:shoes_shop_app/home/components/shoes_card.dart';

class ProductDisplayList extends StatelessWidget {
  const ProductDisplayList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.64,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
        ShoesCard(
          imageUrl:
              "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80",
          name: "Fila Windshift 15",
          rating: 4.5,
          sold: 8374,
          price: 85,
        ),
      ],
    );
  }
}