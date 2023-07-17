import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/cart.dart';
import 'package:shoes_shop_app/service/cart_service.dart';
import 'package:shoes_shop_app/views/order/component/remove_from_cart_sheet.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    super.key,
    this.isDiableRemove,
    required this.cartItem,
    required this.onPressDelete,
  });

  final bool? isDiableRemove;
  final CartItem cartItem;
  final Function(int) onPressDelete;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  RxInt quantity = 0.obs;
  void onQuantityChanged(int value) async {
    CartItem response = await CartService()
        .updateQuantity(widget.cartItem.id, value, widget.cartItem.size);
    if (response.id != 0) {
      quantity.value = response.quantity;
    }
  }

  @override
  void initState() {
    quantity.value = widget.cartItem.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: AppColors.secondBackgroundColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.cartItem.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: (widget.isDiableRemove == true) ? 12 : 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SizedBox(
                          child: Text(
                            widget.cartItem.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      widget.isDiableRemove == true
                          ? Container()
                          : IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return RemoveFromCartSheet(
                                      cartItem: widget.cartItem,
                                      onPressDelete: widget.onPressDelete,
                                    );
                                  },
                                );
                              },
                              icon: Image.asset(
                                "assets/images/trash_icon.png",
                                height: 18,
                                width: 18,
                              ),
                              splashRadius: 18,
                            ),
                    ],
                  ),
                  SizedBox(height: (widget.isDiableRemove == true) ? 12 : 0),
                  Text(
                    "Size = ${widget.cartItem.size}",
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "\$${widget.cartItem.price}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: AppColors.secondBackgroundColor,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 28,
                                width: 28,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    onQuantityChanged(quantity.value - 1);
                                  },
                                  icon: Image.asset(
                                    "assets/images/subtract_icon.png",
                                    height: 12,
                                    width: 12,
                                  ),
                                  splashRadius: 12,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                                child: Text(
                                  "${quantity.value}",
                                  style: GoogleFonts.poppins(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 28,
                                width: 28,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    onQuantityChanged(quantity.value + 1);
                                  },
                                  icon: Image.asset(
                                    "assets/images/plus_icon.png",
                                    height: 12,
                                    width: 12,
                                  ),
                                  splashRadius: 12,
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
          )
        ],
      ),
    );
  }
}
