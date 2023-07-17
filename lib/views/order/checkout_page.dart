import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/address.dart';
import 'package:shoes_shop_app/model/cart.dart';
import 'package:shoes_shop_app/model/promote.dart';
import 'package:shoes_shop_app/service/address_service.dart';
import 'package:shoes_shop_app/service/cart_service.dart';
import 'package:shoes_shop_app/service/promote_service.dart';
import 'package:shoes_shop_app/views/order/add_promo_page.dart';
import 'package:shoes_shop_app/views/order/chose_shipping_page.dart';
import 'package:shoes_shop_app/views/order/component/ordered_order.dart';
import 'package:shoes_shop_app/views/order/payment_page.dart';
import 'package:shoes_shop_app/views/order/shipping_address_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  RxList<CartItem> listCartItem = <CartItem>[].obs;
  Address defaultAddress = Address();
  int shippingMethodIndex = 0;
  RxList<Promote> listPromote = <Promote>[].obs;
  int selectedPromoteIndex = -1;
  final promoteTextFieldController = TextEditingController();
  double totalPrice = 0;
  int cartId = 0;

  List<dynamic> listShippingMethod = [
    {"name": "Normal", "price": 10, "type": "NORMAL"},
    {"name": "Fast", "price": 15, "type": "FAST"},
    {"name": "Express", "price": 20, "type": "EXPRESS"},
  ];

  Future<void> init() async {
    defaultAddress = await AddressService().getDefaultAddress();
    var responseGetAll = await CartService().getAllCartItem();
    List<CartItem> list = responseGetAll["list"];
    totalPrice = responseGetAll["totalPrice"];
    cartId = responseGetAll["cartId"];
    listCartItem.value = list;
    List<Promote> lsPromote = await PromoteService().getAllPromote();
    listPromote.value = lsPromote;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  double calculateTotalPrice() {
    if (selectedPromoteIndex >= 0) {
      return (1 - listPromote[selectedPromoteIndex].discountValue) *
              totalPrice +
          listShippingMethod[shippingMethodIndex]["price"];
    }
    return totalPrice + listShippingMethod[shippingMethodIndex]["price"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Checkout",
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
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shipping address",
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
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
                                Text(
                                  defaultAddress.addressName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  defaultAddress.addressDetail,
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
                            icon: Image.asset("assets/images/edit_icon.png"),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ShippingAddressPage(),
                                ),
                              )
                                  .then((value) {
                                setState(() {
                                  defaultAddress = value;
                                });
                              });
                            },
                            splashRadius: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    "Order List",
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                      children: List.generate(
                          listCartItem.length,
                          (index) => OrderedCard(
                                cartItem: listCartItem[index],
                              ))),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    "Choose shipping",
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
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
                          const SizedBox(width: 20),
                          Image.asset(
                            "assets/images/truck_icon.png",
                            color: AppColors.secondaryColor,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chose Shipping Type",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      listShippingMethod[shippingMethodIndex]
                                          ["name"],
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${listShippingMethod[shippingMethodIndex]["price"]}\$",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Image.asset(
                                "assets/images/right_navigation_icon.png"),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => ChoseShippingPage(
                                    selectedIndex: shippingMethodIndex,
                                  ),
                                ),
                              )
                                  .then((value) {
                                setState(() {
                                  shippingMethodIndex = value;
                                });
                              });
                            },
                            splashRadius: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    "Discount percent",
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: promoteTextFieldController,
                          enabled: false,
                          cursorColor: AppColors.secondaryTextColor,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(12.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            hintText: "Enter promote code",
                            hintStyle: GoogleFonts.poppins(
                              color: AppColors.hintTextColor,
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: AppColors.secondBackgroundColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => AddPromoPage(
                                listPromote: listPromote,
                                selectedIndex: selectedPromoteIndex,
                              ),
                            ),
                          )
                              .then((value) {
                            setState(() {
                              selectedPromoteIndex = value;
                            });
                            if (value >= 0) {
                              promoteTextFieldController.text =
                                  "Discount: ${(listPromote[selectedPromoteIndex].discountValue * 100).toStringAsFixed(0)}%";
                            } else {
                              promoteTextFieldController.text = "";
                            }
                          });
                        },
                        icon: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondaryColor,
                          ),
                          child: Image.asset(
                            "assets/images/plus_icon.png",
                            color: AppColors.primaryColor,
                          ),
                        ),
                        splashRadius: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Amount",
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${totalPrice.toStringAsFixed(2)} \$",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              "Discount",
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "- ${((selectedPromoteIndex >= 0 ? listPromote[selectedPromoteIndex].discountValue : 0) * totalPrice).toStringAsFixed(0)} \$",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              "Shipping",
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "+ ${listShippingMethod[shippingMethodIndex]["price"]} \$",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              "Total",
                              style: GoogleFonts.raleway(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${calculateTotalPrice().toStringAsFixed(2)} \$",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PaymentPage(
                                    cartId: cartId,
                                    shippingAddress:
                                        defaultAddress.addressDetail,
                                    shippingMethod:
                                        listShippingMethod[shippingMethodIndex]
                                            ["type"]),
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
                                "Continue to Payment",
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Image.asset(
                                "assets/images/arrow_right_icon.png",
                                width: 16,
                                height: 16,
                                color: AppColors.primaryColor,
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
      ),
    );
  }
}
