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
  RxBool isFetching = false.obs;
  int totalPages = 0;
  int currentPage = 0;
  final scrollController = ScrollController();

  Future<void> init() async {
    isLoading.value = true;
    currentPage = 0;
    var responseData = await FavoriteService().getListFavorite(currentPage);
    listShoes.value = responseData["list"];
    totalPages = responseData["totalPages"];
    currentPage++;
    isLoading.value = false;
  }

  Future<void> fetchMore() async {
    if (currentPage < totalPages) {
      var responseData = await FavoriteService().getListFavorite(currentPage);
      listShoes.value = listShoes.toList() + responseData["list"];
      currentPage = currentPage + 1;
    }
  }

  @override
  void initState() {
    init();
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        isFetching.value = true;
        await fetchMore();
        await Future.delayed(const Duration(seconds: 1));
        isFetching.value = false;
      }
    });
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
                          controller: scrollController,
                          child: Column(
                            children: [
                              ProductDisplayList(shoes: listShoes),
                              isFetching.value
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        LoadingAnimationWidget
                                            .staggeredDotsWave(
                                          color: Colors.red,
                                          size: 48,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              isFetching.value
                                  ? Container()
                                  : const SizedBox(height: 68),
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
