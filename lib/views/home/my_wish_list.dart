import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/favorite_service.dart';
import 'package:shoes_shop_app/views/home/components/product_display_list.dart';

class MyWishList extends StatefulWidget {
  const MyWishList({super.key});

  @override
  State<MyWishList> createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  RxList<Shoes> listShoes = <Shoes>[].obs;
  RxBool isLoading = false.obs;

  Future<void> init() async {
    isLoading.value = true;
    List<Shoes> list = await FavoriteService().getListFavorite();
    listShoes.value = list;
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
        title: Text(
          "My Wishlist",
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrow_icon.svg"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          splashRadius: 24,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: isLoading.value
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.red,
                          size: 48,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: SingleChildScrollView(
                            child: ProductDisplayList(shoes: listShoes)),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
