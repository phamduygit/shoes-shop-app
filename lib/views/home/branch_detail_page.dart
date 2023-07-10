import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/model/shoes.dart';
import 'package:shoes_shop_app/service/shoes_service.dart';
import 'package:shoes_shop_app/views/home/search_page.dart';

import 'components/product_display_list.dart';

class BranchDetailPage extends StatefulWidget {
  const BranchDetailPage({super.key, required this.title, required this.id});

  final String title;
  final int id;

  @override
  State<BranchDetailPage> createState() => _BranchDetailPageState();
}

class _BranchDetailPageState extends State<BranchDetailPage> {
  RxBool isNeedFetch = false.obs;
  List<Shoes> listShoes = [];
  final scrollController = ScrollController();
  int totalPage = 0;
  int currentPage = 1;

  Future<void> init() async {
    isNeedFetch.value = true;
    var response = await ShoesService().getAllShoesByBrandId(widget.id, 0);
    totalPage = response["totalPages"];
    listShoes = response["listShoes"];
    isNeedFetch.value = false;
  }

  Future<void> fetchPage(int pageKey) async {
    if (pageKey < totalPage) {
      var response =
          await await ShoesService().getAllShoesByBrandId(widget.id, pageKey);
      listShoes = listShoes + response["listShoes"];
      currentPage = currentPage + 1;
    }
  }

  @override
  void initState() {
    init();
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        isNeedFetch.value = true;
        await fetchPage(currentPage);
        await Future.delayed(const Duration(seconds: 1));
        isNeedFetch.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
        actions: [
          IconButton(
            icon: Image.asset("assets/images/magnifying_icon.png"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SerachPage(),
                ),
              );
            },
            splashRadius: 24,
          ),
        ],
        elevation: 0,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                ProductDisplayList(shoes: listShoes),
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
                isNeedFetch.value ? Container() : const SizedBox(height: 68),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
