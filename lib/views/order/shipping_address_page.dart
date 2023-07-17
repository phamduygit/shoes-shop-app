import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/address.dart';
import 'package:shoes_shop_app/service/address_service.dart';
import 'package:shoes_shop_app/views/order/component/edit_shipping_address.dart';
import 'package:shoes_shop_app/views/profile/address_page.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  RxBool isLoading = false.obs;
  RxList<Address> listAddress = <Address>[].obs;
  RxInt selectedIndex = 0.obs;
  Future<void> init() async {
    isLoading.value = true;
    List<Address> list = await AddressService().getListAddress();
    selectedIndex.value = list.indexWhere((element) => element.selected);
    listAddress.value = list;
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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Shipping Address",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/arrow_icon.svg"),
          onPressed: () {
            Navigator.of(context).pop(listAddress[selectedIndex.value]);
          },
          splashRadius: 24,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                          listAddress.length,
                          (index) => EditAddressCard(
                            name: listAddress[index].addressName,
                            description: listAddress[index].addressDetail,
                            isSelected: index == selectedIndex.value,
                            onPressed: () {
                              selectedIndex.value = index;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddressPage(),
                                      ),
                                    )
                                    .then((value) => init());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.secondBackgroundColor,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add New Address",
                                    style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(listAddress[selectedIndex.value]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Apply",
                              style: GoogleFonts.raleway(
                                fontSize: 18,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
