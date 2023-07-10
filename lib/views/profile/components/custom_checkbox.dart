import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_app/constant/colors.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required this.isSelected,
    required this.onPressCheckBox,
  });

  final bool isSelected;
  final Function(bool) onPressCheckBox;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isSelectedCheckBox = false;

  @override
  void initState() {
    isSelectedCheckBox = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppColors.secondaryColor;
      }
      return AppColors.secondaryColor;
    }

    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isSelectedCheckBox,
          onChanged: (bool? value) {
            setState(() {
              isSelectedCheckBox = !isSelectedCheckBox;
            });
            widget.onPressCheckBox(isSelectedCheckBox);
          },
        ),
        Text(
          "Make this as the default address",
          style: GoogleFonts.raleway(
            fontSize: 14,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
