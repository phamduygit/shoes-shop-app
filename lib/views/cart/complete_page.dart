import 'package:flutter/material.dart';
import 'package:shoes_shop_app/views/cart/component/tracker_order_card.dart';
import 'package:shoes_shop_app/views/cart/track_order_page.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TrackedOrderCard(
            status: "Completed",
            titleButton: "Leave Review",
            onPressButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrackOrderPage(),
                ),
              );
            },
          ),
          TrackedOrderCard(
            status: "Completed",
            titleButton: "Leave Review",
            onPressButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrackOrderPage(),
                ),
              );
            },
          ),
          TrackedOrderCard(
            status: "Completed",
            titleButton: "Leave Review",
            onPressButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrackOrderPage(),
                ),
              );
            },
          ),
          TrackedOrderCard(
            status: "Completed",
            titleButton: "Buy again",
            onPressButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrackOrderPage(),
                ),
              );
            },
          ),
          TrackedOrderCard(
            status: "Completed",
            titleButton: "Buy again",
            onPressButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrackOrderPage(),
                ),
              );
            },
          ),
          TrackedOrderCard(
            status: "Completed",
            titleButton: "Buy again",
            onPressButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrackOrderPage(),
                ),
              );
            },
          ),
          TrackedOrderCard(
            status: "Completed",
            titleButton: "Buy again",
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
    );
  }
}
