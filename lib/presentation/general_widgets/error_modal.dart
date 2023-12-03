import 'package:flutter/material.dart';
import 'package:send_now_test/core/extensions/texttheme_extensions.dart';

class MessageModal extends StatelessWidget {
  const MessageModal({
    Key? key,
    required this.message,
    this.text = 'Okay',
    this.onDismissed,
  }) : super(key: key);
  final String message, text;
  final void Function()? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 44, right: 35, left: 35, bottom: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(
              height: 41,
            ),
            Icon(Icons.dangerous, size: 60, color: Colors.red.shade900),
            const SizedBox(
              height: 31,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.text2Regular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            TextButton(
              onPressed: onDismissed ?? () => Navigator.pop(context),
              child: Text(
                text,
                style: Theme.of(context).textTheme.text2Regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<T?> showErrorSnack<T>({
  required String message,
  String text = 'Okay',
  required BuildContext context,
  VoidCallback? onDismissed,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return MessageModal(
        message: message,
        onDismissed: onDismissed,
        text: text,
      );
    },
  );
}
