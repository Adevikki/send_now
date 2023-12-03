import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:send_now_test/core/extensions/texttheme_extensions.dart';
import 'package:send_now_test/core/utils/colors.dart';
import 'package:send_now_test/data/model/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: SendNowColors.greyBorder,
            ),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              'assets/svgs/google_icon.svg',
              height: 20,
              width: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transaction.id, // Use transaction data here
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: SendNowColors.black),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      transaction.status, // Use transaction status here
                      style: Theme.of(context).textTheme.text1Bold.copyWith(
                            color: SendNowColors.black.withOpacity(0.5),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
