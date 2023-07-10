import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/views/profile/components/custom_checkbox.dart';

class AddressBottomModalSheet extends StatefulWidget {
  const AddressBottomModalSheet({
    super.key,
    required this.nameAddressController,
    required this.addressDetailController,
    required this.isSelected,
    required this.titleButton,
    required this.onPress,
  });

  final TextEditingController nameAddressController;
  final TextEditingController addressDetailController;
  final bool isSelected;
  final String titleButton;
  final Function(bool) onPress;

  @override
  State<AddressBottomModalSheet> createState() =>
      _AddressBottomModalSheetState();
}

class _AddressBottomModalSheetState extends State<AddressBottomModalSheet> {
  bool isSelectedCheckBox = false;

  void onPressCheckBox(bool value) {
    setState(() {
      isSelectedCheckBox = value;
    });
  }

  @override
  void initState() {
    isSelectedCheckBox = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Address Detail",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name address",
                      style: GoogleFonts.raleway(
                        fontSize: 14,
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: widget.nameAddressController,
                        cursorColor: AppColors.secondaryTextColor,
                        style: GoogleFonts.poppins(
                          color: AppColors.secondaryTextColor,
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 12.0),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          hintText: "Home, Apartment, Company,...",
                          hintStyle: GoogleFonts.poppins(
                            color: AppColors.hintTextColor,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColors.backgroundTextField,
                          hoverColor: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Address detail",
                      style: GoogleFonts.raleway(
                        fontSize: 14,
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: widget.addressDetailController,
                        cursorColor: AppColors.secondaryTextColor,
                        style: GoogleFonts.poppins(
                          color: AppColors.secondaryTextColor,
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 12.0),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          hintText: "2899 Summer Drive Talor, PC 48180",
                          hintStyle: GoogleFonts.poppins(
                            color: AppColors.hintTextColor,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColors.backgroundTextField,
                          hoverColor: AppColors.secondaryTextColor,
                          suffixIcon: Image.asset(
                            "assets/images/location_icon.png",
                          ),
                        ),
                      ),
                    ),
                    CustomCheckBox(
                      isSelected: widget.isSelected,
                      onPressCheckBox: onPressCheckBox,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        widget.onPress(isSelectedCheckBox);
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
                            widget.titleButton,
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
