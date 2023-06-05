import 'package:flutter/material.dart';
import 'package:shoes_shop_app/cart/component/empty_content.dart';
import 'package:shoes_shop_app/cart/component/tracker_order_card.dart';
import 'package:shoes_shop_app/cart/track_order_page.dart';

class ActivePage extends StatelessWidget {
  const ActivePage({
    super.key,
    required this.orders,
  });

  final int orders;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: orders > 0
          ? SingleChildScrollView(
              child: Column(
                children: [
                  TrackedOrderCard(
                    status: "In Delivery",
                    titleButton: "Tracker Order",
                    onPressButton: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TrackOrderPage(),
                        ),
                      );
                    },
                  ),
                  TrackedOrderCard(
                    status: "In Delivery",
                    titleButton: "Tracker Order",
                    onPressButton: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TrackOrderPage(),
                        ),
                      );
                    },
                  ),
                  TrackedOrderCard(
                    status: "In Delivery",
                    titleButton: "Tracker Order",
                    onPressButton: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TrackOrderPage(),
                        ),
                      );
                    },
                  ),
                  TrackedOrderCard(
                    status: "In Delivery",
                    titleButton: "Tracker Order",
                    onPressButton: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TrackOrderPage(),
                        ),
                      );
                    },
                  ),
                  TrackedOrderCard(
                    status: "In Delivery",
                    titleButton: "Tracker Order",
                    onPressButton: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TrackOrderPage(),
                        ),
                      );
                    },
                  ),
                  TrackedOrderCard(
                    status: "In Delivery",
                    titleButton: "Tracker Order",
                    onPressButton: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TrackOrderPage(),
                        ),
                      );
                    },
                  ),
                  TrackedOrderCard(
                    status: "In Delivery",
                    titleButton: "Tracker Order",
                    onPressButton: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TrackOrderPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : const EmptyContent(),
    );
  }
}
