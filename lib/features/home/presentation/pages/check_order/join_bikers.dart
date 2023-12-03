import 'package:flutter/material.dart';
import 'package:send_now_test/core/utils/assets.dart';
import 'package:send_now_test/core/utils/colors.dart';

class JoinBikersWidget extends StatelessWidget {
  const JoinBikersWidget({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            Assets.bike,
            fit: BoxFit.cover,
            height: 120,
            width: 120,
          ),
          const SizedBox(width: 4),
          const Text(
            "You too can join our \nElite squad of E-bikers",
            style: TextStyle(
              color: SendNowColors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
