import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';
import 'package:shoes_shop_app/model/order.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key, required this.order});

  final Order order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Track Order",
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              OneTrackOrderCard(
                order: order,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    OrderStatus(imageUri: "assets/images/package_icon.png"),
                    Text("- - - -"),
                    OrderStatus(imageUri: "assets/images/truck_icon.png"),
                    Text("- - - -"),
                    OrderStatus(imageUri: "assets/images/receive_icon.png"),
                    Text("- - - -"),
                    OrderStatus(imageUri: "assets/images/unbox_icon.png"),
                  ],
                ),
              ),
              Text(
                "Packge In Delivery",
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Order Status Details",
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  OrderStatusDetailCell(),
                  Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text("- - - -"),
                    ),
                  ),
                  OrderStatusDetailCell(),
                  Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text("- - - -"),
                    ),
                  ),
                  OrderStatusDetailCell(),
                  Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text("- - - -"),
                    ),
                  ),
                  OrderStatusDetailCell(),
                  Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text("- - - -"),
                    ),
                  ),
                  OrderStatusDetailCell(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStatusDetailCell extends StatelessWidget {
  const OrderStatusDetailCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 6.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order In Transit - Dec 17",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "32 Machester Ave. Ringgold. GA 30736",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "15:20 PM",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    super.key,
    required this.imageUri,
  });

  final String imageUri;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUri),
        const SizedBox(
          height: 12,
        ),
        Image.asset(
          "assets/images/tick_icon.png",
          width: 14,
          height: 14,
        ),
      ],
    );
  }
}

class OneTrackOrderCard extends StatelessWidget {
  const OneTrackOrderCard({
    super.key,
    required this.order,
  });

  final Order order;

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
                color: AppColors.secondBackgroundColor),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                order.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SizedBox(
                          child: Text(
                            order.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ),
                  Text(
                    "Size = ${order.size}  |  Qty = ${order.quantity}",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: AppColors.secondaryTextColor),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.secondBackgroundColor),
                    child: Text(
                      order.shippingStatus,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text(
                    "\$${order.price}",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
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
