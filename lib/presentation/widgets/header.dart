import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    this.onTap,
    required this.showArrow,
  });

  final VoidCallback? onTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        Row(
          children: [
            InkWell(
              onTap: onTap,
              child: InkWell(
                child: Image.asset(Assets.profilePic),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(Assets.notification),
                ),
                const SizedBox(width: 10),
                if (showArrow)
                  InkWell(
                    onTap: onTap,
                    child: Transform.rotate(
                      angle: -180 * (pi / 180),
                      child: SvgPicture.asset(
                        Assets.arrow,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          getGreeting(
            'Victor',
          ),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: SendNowColors.black,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 5),
      ]),
    );
  }
}

String getGreeting(String userName) {
  late String greeting;

  int hours = DateTime.now().hour;

  if (hours >= 0 && hours <= 12) {
    greeting = "Good Morning $userName 🌅";
  } else if (hours >= 12 && hours <= 16) {
    greeting = "Good Afternoon $userName 🌞";
  } else if (hours >= 16 && hours <= 21) {
    greeting = "Good Evening $userName 🌇";
  } else if (hours >= 21 && hours <= 24) {
    greeting = "Good Night $userName 🛌🏻";
  }

  return greeting;
}
