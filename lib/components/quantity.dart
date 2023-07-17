import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    super.key,
    required this.value,
    required this.onChangeQuantity,
  });

  final int value;
  final Function(int) onChangeQuantity;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                widget.onChangeQuantity(widget.value - 1);
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
              "${widget.value}",
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
                widget.onChangeQuantity(widget.value + 1);
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
    );
  }
}
