import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import 'join_bikers.dart';
import '../track_order/track_orders_card.dart';

class CheckOrderPage extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final void Function(int)? onPageChanged;
  final void Function()? onOrderClicked;

  const CheckOrderPage({
    super.key,
    required this.pageController,
    required this.currentPage,
    this.onPageChanged,
    this.onOrderClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: PageView.builder(
              // physics: NeverScrollableScrollPhysics(),
              onPageChanged: onPageChanged,
              controller: pageController,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: SendNowColors.greyBorder,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        "assets/images/bicycle.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == currentPage
                                ? SendNowColors.grey
                                : SendNowColors.greyBorder,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
            child: Container(
              color: SendNowColors.yellow,
              child: YourOrders(
                onTap: () => onOrderClicked!(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            child: JoinBikersWidget(onTap: () {}),
          ),
        ],
      ),
    );
  }
}
