import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'colors.dart';

class CarryNaPinInputTheme extends PinTheme {
  final BuildContext context;

  CarryNaPinInputTheme({
    required this.context,
    double width = 50,
    double height = 46,
    Color color = SendNowColors.white,
    Color borderColor = SendNowColors.primaryColor,
  }) : super(
          width: width,
          height: height,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        );
}
