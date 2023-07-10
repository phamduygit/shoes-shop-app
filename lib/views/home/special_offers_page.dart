import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoes_shop_app/model/promote.dart';
import 'package:shoes_shop_app/service/promote_service.dart';
import 'package:shoes_shop_app/utils/string_covert.dart';
import 'package:shoes_shop_app/views/home/components/special_offers_card.dart';

class SpecialOffersPage extends StatefulWidget {
  const SpecialOffersPage({super.key});

  @override
  State<SpecialOffersPage> createState() => _SpecialOffersPageState();
}

class _SpecialOffersPageState extends State<SpecialOffersPage> {
  RxBool isLoading = false.obs;
  List<Promote> listPromteData = [];

  Future<void> init() async {
    isLoading.value = true;
    var response = await PromoteService().getAllPromote();
    if (response != null) {
      listPromteData = response;
    }
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
          "Special Offers",
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
      body: Obx(
        () => SafeArea(
          child: isLoading.value
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.red,
                    size: 48,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      listPromteData.length,
                      (index) => SpecialOfferCard(
                        backgroundColor: StringConvert()
                            .hexStringToColor(listPromteData[index].color),
                        imageUrl: listPromteData[index].coverImage,
                        percentDiscount: listPromteData[index].discountValue,
                        title: listPromteData[index].title,
                        description: listPromteData[index].description,
                      ),
                    ),
                    // children: const [
                    //   SpecialOfferCard(
                    //     backgroundColor: AppColors.redColorForDiscount,
                    //     imageUrl:
                    //         'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                    //     percentDiscount: 25,
                    //     title: 'Today Special!',
                    //     description:
                    //         "Get discount for every \norder, only valid for today",
                    //   ),
                    //   SpecialOfferCard(
                    //     backgroundColor: Color(0xFFedbeea),
                    //     imageUrl:
                    //         'https://images.unsplash.com/photo-1605408499391-6368c628ef42?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
                    //     percentDiscount: 25,
                    //     title: 'Weekends Deals',
                    //     description:
                    //         "Get discount for every \norder, only valid for today",
                    //   ),
                    // ],
                  ),
                ),
        ),
      ),
    );
  }
}
