import 'package:flutter/material.dart';

class StringConvert {
  Color hexStringToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}