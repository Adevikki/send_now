import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/colors.dart';

class YourOrders extends StatelessWidget {
  const YourOrders({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "Gotten your\n E-Bike yet?",
          style: TextStyle(
            color: SendNowColors.primarylight,
            fontSize: 16,
          ),
        ),
        OrderButton(
          onTap: onTap,
          text: 'Your orders',
        ),
      ],
    );
  }
}

class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(52),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                Assets.arrow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
