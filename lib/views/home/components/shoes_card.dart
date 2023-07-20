import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/controller/auth_controller.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/favorite_service.dart';
import 'package:shoes_shop_app/views/home/product_detail_page.dart';

class ShoesCard extends StatefulWidget {
  const ShoesCard({
    super.key,
    required this.shoes,
  });

  final Shoes shoes;

  @override
  State<ShoesCard> createState() => _ShoesCardState();
}

class _ShoesCardState extends State<ShoesCard> {
  RxBool isFavorite = false.obs;
  final AuthController authController = Get.find();

  void onPresssHeartIcon() async {
    if (isFavorite.value) {
      bool response = await FavoriteService().removeFavorite(widget.shoes.id);
      if (response) {
        isFavorite.value = false;
      }
    } else {
      Shoes shoes = await FavoriteService().addAddFavorite(widget.shoes.id);
      if (shoes.favorite) {
        isFavorite.value = true;
      } else {
        authController.setAuthorize(false);
      }
    }
  }

  @override
  void initState() {
    isFavorite.value = widget.shoes.favorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              id: widget.shoes.id,
            ),
          ),
        );
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      widget.shoes.coverImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: IconButton(
                    splashRadius: 16,
                    onPressed: onPresssHeartIcon,
                    icon: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondaryColor,
                      ),
                      child: Obx(
                        () => Image.asset(
                          isFavorite.value
                              ? "assets/images/heart_fill_icon.png"
                              : "assets/images/heart_icon.png",
                          height: 18,
                          width: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              widget.shoes.name,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.star_rounded),
                const SizedBox(width: 5),
                Text("${widget.shoes.rating}"),
                const SizedBox(width: 5),
                const Text("|"),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.backgroundTextField,
                  ),
                  child: Text(
                    "${widget.shoes.sold} sold",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              "\$${widget.shoes.price}",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
