import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/controller/list_address_controller.dart';
import 'package:shoes_shop_app/model/address.dart';
import 'package:shoes_shop_app/service/address_service.dart';
import 'package:shoes_shop_app/views/profile/components/address_bottom_modal_sheet.dart';

class AddressRow extends StatefulWidget {
  const AddressRow({
    super.key,
    required this.address,
  });

  final Address address;

  @override
  State<AddressRow> createState() => _AddressRowState();
}

class _AddressRowState extends State<AddressRow> {
  final nameAddressController = TextEditingController();
  final addressDetailController = TextEditingController();
  final ListAddressController listAddressController = Get.find();

  void onPressUpdateButton(bool value) async {
    // isLoading.value = true;
    debugPrint("Checkbox value: $value");
    debugPrint("Name address: ${nameAddressController.text}");
    debugPrint("Address detai: ${addressDetailController.text}");
    Address address = Address(
      addressName: nameAddressController.text,
      addressDetail: addressDetailController.text,
      selected: value,
      id: widget.address.id,
    );
    await AddressService().updateAddress(address);
    List<Address> list = await AddressService().getListAddress();
    listAddressController.updateList(list);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    nameAddressController.text = widget.address.addressName;
    addressDetailController.text = widget.address.addressDetail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.circleBorderColor,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondaryColor,
                ),
                child: Image.asset(
                  "assets/images/location_icon.png",
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.address.addressName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      widget.address.selected
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: AppColors.bacdgroundText,
                              ),
                              child: Text(
                                "Default",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Text(
                    widget.address.addressDetail,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                child: Image.asset("assets/images/pencil_icon.png"),
              ),
              onPressed: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => AddressBottomModalSheet(
                    nameAddressController: nameAddressController,
                    addressDetailController: addressDetailController,
                    isSelected: widget.address.selected,
                    titleButton: "Save",
                    onPress: onPressUpdateButton,
                  ),
                );
              },
              splashRadius: 18,
            )
          ],
        ),
      ),
    );
  }
}
