import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/cart.dart';
import 'package:shoes_shop_app/service/cart_service.dart';
import 'package:shoes_shop_app/views/cart/component/empty_content.dart';
import 'package:shoes_shop_app/views/home/search_page.dart';
import 'package:shoes_shop_app/views/order/component/footer_order.dart';
import 'package:shoes_shop_app/views/order/component/order_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  RxList<CartItem> listCartItem = <CartItem>[].obs;
  final scrollController = ScrollController();
  double totalPrice = 0;
  RxBool isLoading = false.obs;
  RxBool isFetchMore = false.obs;
  int currentPage = 1;
  int totalPages = 0;

  Future<void> init() async {
    currentPage = 1;
    isLoading.value = true;
    var response = await CartService().getCarts(null);
    totalPages = response["totalPages"];
    totalPrice = response["totalPrice"];
    listCartItem.value = response["list"];
    isLoading.value = false;
  }

  void onPressDelete(int value) async {
    var response = await CartService().deleteCartItem(value);
    if (response) {
      init();
    }
  }

  void onQuantityChanged(int shoesId, int quanity) {
    int index = listCartItem.indexWhere((element) => element.id == shoesId);
    listCartItem.removeLast;
    debugPrint("Shoes ID: $shoesId, quantity: ${listCartItem[index].quantity}");
  }

  @override
  void initState() {
    init();
    currentPage = 1;
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        isFetchMore.value = true;
        var response = await CartService().getCarts(currentPage);
        if (response != null) {
          listCartItem.value = listCartItem.toList() + response["list"];

          if (currentPage < totalPages) {
            currentPage++;
          }
        }
        await Future.delayed(const Duration(seconds: 1));
        isFetchMore.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SerachPage(),
                ),
              );
            },
            icon: Image.asset("assets/images/magnifying_icon.png"),
            splashRadius: 24,
          ),
        ],
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SafeArea(
        child: Obx(
          () => isLoading.value
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.red,
                    size: 48,
                  ),
                )
              : listCartItem.isNotEmpty ? Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Column(
                                children: List.generate(
                              listCartItem.length,
                              (index) => OrderCard(
                                isDiableRemove: false,
                                cartItem: listCartItem[index],
                                onPressDelete: onPressDelete,
                              ),
                            )),
                            isFetchMore.value
                                ? Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      LoadingAnimationWidget.staggeredDotsWave(
                                        color: Colors.red,
                                        size: 48,
                                      ),
                                    ],
                                  )
                                : Container(),
                            isFetchMore.value
                                ? Container()
                                : const SizedBox(height: 68),
                          ],
                        ),
                      ),
                    ),
                    FooterOrder(
                      totalPrice: totalPrice,
                    ),
                  ],
                ) : const EmptyContent(),
        ),
      ),
    );
  }
}
