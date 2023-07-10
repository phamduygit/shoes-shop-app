import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/controller/list_address_controller.dart';
import 'package:shoes_shop_app/model/address.dart';
import 'package:shoes_shop_app/service/address_service.dart';
import 'package:shoes_shop_app/views/profile/components/address_bottom_modal_sheet.dart';
import 'package:shoes_shop_app/views/profile/components/address_row.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final nameAddressController = TextEditingController();
  final addressDetailController = TextEditingController();
  RxBool isLoading = false.obs;
  final ListAddressController listAddress = Get.put(ListAddressController());

  void onPressAddButton(bool value) async {
    isLoading.value = true;
    debugPrint("Checkbox value: $value");
    debugPrint("Name address: ${nameAddressController.text}");
    debugPrint("Address detai: ${addressDetailController.text}");
    Address address = Address(
      addressName: nameAddressController.text,
      addressDetail: addressDetailController.text,
      selected: value,
    );
    await AddressService().addAddress(address);
    List<Address> list = await AddressService().getListAddress();
    listAddress.updateList(list);

    isLoading.value = false;
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> init() async {
    isLoading.value = true;
    List<Address> list = await AddressService().getListAddress();
    listAddress.updateList(list);
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
            Navigator.of(context).pop(true);
          },
          splashRadius: 24,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => isLoading.value
              ? Container(
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.red,
                      size: 48,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: List.generate(
                            listAddress.getList().length,
                            (index) => AddressRow(
                              address: listAddress.getList()[index],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) => AddressBottomModalSheet(
                                    nameAddressController:
                                        nameAddressController,
                                    addressDetailController:
                                        addressDetailController,
                                    isSelected: false,
                                    titleButton: "Add",
                                    onPress: onPressAddButton,
                                  ),
                                );
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
                                    "Add new address",
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
