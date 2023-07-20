import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/components/confirm_dialog_with_button.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/controller/index_navigation_controller.dart';
import 'package:shoes_shop_app/service/order_service.dart';
import 'package:shoes_shop_app/views/order/component/payment_method_card.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {super.key,
      required this.cartId,
      required this.shippingAddress,
      required this.shippingMethod});

  final int cartId;
  final String shippingAddress;
  final String shippingMethod;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<String> listMethod = ["CASH", "PAYPAL", "GOOGLE_PAY", "CARD"];
  String selectedMethod = "CASH";
  IndexNavigationController index = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Payment methods",
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
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Select the payment method you want to use",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.secondaryTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    PaymentMethodCard(
                      name: "Cash",
                      isSelected: selectedMethod == "CASH",
                      onPressed: () {
                        setState(() {
                          selectedMethod = "CASH";
                        });
                      },
                      iconUri: "assets/images/wallet_fill_icon.png",
                      price: "",
                    ),
                    PaymentMethodCard(
                      name: "Paypal",
                      isSelected: selectedMethod == "PAYPAL",
                      onPressed: () {
                        setState(() {
                          selectedMethod = "PAYPAL";
                        });
                      },
                      iconUri: "assets/images/paypal_icon.png",
                      price: "",
                    ),
                    PaymentMethodCard(
                      name: "Google pay",
                      isSelected: selectedMethod == "GOOGLE_PAY",
                      onPressed: () {
                        setState(() {
                          selectedMethod = "GOOGLE_PAY";
                        });
                      },
                      iconUri: "assets/images/google_icon.png",
                      price: "",
                    ),
                    PaymentMethodCard(
                      name: "**** **** **** 1234",
                      isSelected: selectedMethod == "CARD",
                      onPressed: () {
                        setState(() {
                          selectedMethod = "CARD";
                        });
                      },
                      iconUri: "assets/images/mastercard_icon.png",
                      price: "",
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        debugPrint(
                            "cartId: ${widget.cartId}, address: ${widget.shippingAddress}, paymentMethod: $selectedMethod, shippingMethod: ${widget.shippingMethod}");

                        var response = await OrderService().createOrder(
                          widget.cartId,
                          widget.shippingAddress,
                          selectedMethod,
                          widget.shippingMethod,
                        );

                        if (response != null) {
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (buildContext) {
                                return ConfirmDialogWithButton(
                                  subject: 'Thank you for your order',
                                  message: 'Go to home page',
                                  iconPath:
                                      'assets/images/checkmark-done-outline.svg',
                                  color: AppColors.successColor,
                                  onPressed: () {
                                    int count = 0;
                                    Navigator.popUntil(context, (route) {
                                      return count++ == 3;
                                    });
                                    index.setIndex(0);
                                  },
                                );
                              },
                            );
                          }
                        } else {
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (buildContext) {
                                return ConfirmDialogWithButton(
                                  subject: 'Authentication success',
                                  message: 'Your account have been created',
                                  iconPath: 'assets/images/error_icon.svg',
                                  color: AppColors.redColorForDiscount,
                                  onPressed: () {},
                                );
                              },
                            );
                          }
                        }
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
                            "Confirm Payment",
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
    );
  }
}
