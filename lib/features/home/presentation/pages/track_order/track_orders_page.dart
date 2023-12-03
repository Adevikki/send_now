import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/extensions/texttheme_extensions.dart';
import 'package:send_now_test/core/utils/validators.dart';
import 'package:send_now_test/features/home/presentation/notifier/transaction_notifier.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../presentation/widgets/text_form_field.dart';
import '../map/map_page.dart';
import 'track_orders_card.dart';
import 'transaction.dart';

class TrackOrders extends ConsumerStatefulWidget {
  const TrackOrders({Key? key}) : super(key: key);

  @override
  TrackOrdersState createState() => TrackOrdersState();
}

class TrackOrdersState extends ConsumerState<TrackOrders> {
  final TextEditingController _receiptController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
      ref.read(transactionNotifierProvider.notifier).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: SendNowColors.yellow,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Track Your Package",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: SendNowColors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Enter the receipt number that has been given by the officer",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: SendNowColors.primarylight,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      controller: _receiptController,
                      labelText: 'Enter the receipt number',
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      radius: 10.0,
                      borderWidth: 1.0,
                      borderColor: _formKey.currentState?.validate() == false
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 16.0,
                      textColor: Colors.black,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      noBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      validateFunction: Validators.notEmpty(),
                    ),
                    const SizedBox(height: 20),
                    OrderButton(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                receiptNumber: _receiptController.text,
                              ),
                            ),
                          );
                        }
                      },
                      text: 'Track Now',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transactions',
                style: Theme.of(context)
                    .textTheme
                    .text2Bold
                    .copyWith(color: SendNowColors.black),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final transactionState =
                      ref.watch(transactionNotifierProvider);
                  return transactionState.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Text('Error: $error')),
                    data: (transactions) {
                      return ListView.separated(
                        itemBuilder: (ctx, i) =>
                            TransactionTile(transaction: transactions[i]),
                        separatorBuilder: (ctx, i) =>
                            const SizedBox(height: 10),
                        itemCount: transactions.length,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
