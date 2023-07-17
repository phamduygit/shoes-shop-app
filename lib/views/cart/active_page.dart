import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/model/order.dart';
import 'package:shoes_shop_app/service/order_service.dart';
import 'package:shoes_shop_app/views/cart/component/empty_content.dart';
import 'package:shoes_shop_app/views/cart/component/tracker_order_card.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({
    super.key,
    required this.isComplete,
  });

  final bool isComplete;

  @override
  State<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  RxList<Order> listUnCompletedOrder = <Order>[].obs;
  final scrollController = ScrollController();
  int totalPages = 0;
  RxBool isNeedFetch = false.obs;
  int currentPage = 1;
  RxBool isLoading = false.obs;

  Future<void> init() async {
    isLoading.value = true;
    var responseOrderList =
        await OrderService().getOrder(widget.isComplete, null);
    listUnCompletedOrder.value = responseOrderList["list"];
    totalPages = responseOrderList["totalPages"];
    currentPage = 1;
    isLoading.value = false;
  }

  Future<void> fetchMore() async {
    isNeedFetch.value = true;
    if (currentPage >= totalPages) {
      return;
    }
    var responseOrderList =
        await OrderService().getOrder(widget.isComplete, currentPage);
    listUnCompletedOrder.value =
        listUnCompletedOrder.toList() + responseOrderList["list"];
    currentPage++;
    isNeedFetch.value = false;
  }

  @override
  void initState() {
    init();
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        isNeedFetch.value = true;
        await fetchMore();
        await Future.delayed(const Duration(seconds: 1));
        isNeedFetch.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: listUnCompletedOrder.toList().isNotEmpty
            ? SingleChildScrollView(
                controller: scrollController,
                child: isLoading.value
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.red,
                          size: 48,
                        ),
                      )
                    : Column(
                        children: [
                          Column(
                            children: List.generate(
                              listUnCompletedOrder.length,
                              (index) => TrackedOrderCard(
                                order: listUnCompletedOrder[index],
                              ),
                            ),
                          ),
                          isNeedFetch.value
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
                          isNeedFetch.value
                              ? Container()
                              : const SizedBox(height: 68),
                        ],
                      ),
              )
            : const EmptyContent(),
      ),
    );
  }
}
