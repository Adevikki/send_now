import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:send_now_test/core/extensions/texttheme_extensions.dart';

import '../../core/enums.dart';
import '../../core/utils/colors.dart';

class AppOverLay extends StatefulWidget {
  const AppOverLay({
    super.key,
    required this.child,
    required this.controller,
    this.messagePadding,
  });
  final Widget child;
  final OverLayLoaderController controller;
  final EdgeInsetsGeometry? messagePadding;

  @override
  State<AppOverLay> createState() => _AppOverLayState();

  static _AppOverLayState of(BuildContext context) {
    final _AppOverLayState? result =
        context.findAncestorStateOfType<_AppOverLayState>();
    if (result != null) return result;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        'AppOverLay.of() called with a context that does not contain a AppOverLay.',
      ),
      ErrorDescription(
        'No AppOverLay ancestor could be found starting from the context that was passed to AppOverLay.of(). '
        'This usually happens when the context provided is from the same StatefulWidget as that '
        'whose build function actually creates the AppOverLay widget being sought.',
      ),
      context.describeElement('The context used was'),
    ]);
  }
}

class _AppOverLayState extends State<AppOverLay> {
  OverLayLoaderController get controller => widget.controller;

  void showMessage({
    required String message,
    String? title,
    required MessageType messageType,
  }) {
    return controller.showMessage(
      message: message,
      messageType: messageType,
      title: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        widget.child,
        ValueListenableBuilder<(OverLayType, _MessageText?)>(
          valueListenable: widget.controller._valueNotifier,
          builder: (context, listen, child) {
            if (listen.$1 == OverLayType.loader) {
              return Positioned.fill(
                child: Material(
                  color: Colors.black.withOpacity(.5),
                  child: const CircularProgressIndicator.adaptive(),
                ),
              );
            } else if (listen.$1 == OverLayType.message) {
              return SafeArea(
                child: Container(
                  padding: widget.messagePadding ?? const EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: -20, end: 0),
                    curve: Curves.easeInOut,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: _messageWidget(
                          messageIcon:
                              listen.$2?.messageType == MessageType.error
                                  ? 'assets/svgs/error.svg'
                                  : 'assets/svgs/success.svg',
                          messageText: listen.$2!,
                          messageColor:
                              listen.$2?.messageType == MessageType.error
                                  ? SendNowColors.primaryColor
                                  : SendNowColors.green,
                          onClose: () {
                            controller.removeOverLay();
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _messageWidget({
    required _MessageText messageText,
    required String messageIcon,
    required Color messageColor,
    required VoidCallback onClose,
  }) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: messageColor),
      ),
      color: messageText.messageType == MessageType.error
          ? const Color(0XFFFFF2F2)
          : const Color(0XFFDCF3EB),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 63.0,
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(messageIcon, height: 30),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (messageText.title != null)
                    Text(
                      messageText.title!,
                      style: Theme.of(context).textTheme.text1Bold.copyWith(
                            color: messageColor,
                            fontSize: 13,
                          ),
                      textDirection: TextDirection.ltr,
                    ),
                  Text(
                    messageText.message,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.text1Regular.copyWith(
                          color: messageColor,
                          fontSize: 13,
                        ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverLayLoaderController {
  final ValueNotifier<(OverLayType, _MessageText?)> _valueNotifier =
      ValueNotifier((OverLayType.none, null));

  void showLoader() {
    _valueNotifier.value = ((OverLayType.loader, null));
  }

  void showMessage({
    required String message,
    String? title,
    required MessageType messageType,
  }) {
    _valueNotifier.value = ((
      OverLayType.message,
      _MessageText(
        title: title,
        message: message,
        messageType: messageType,
      )
    ));
    Future.delayed(const Duration(seconds: 3), () {
      removeOverLay();
    });
  }

  void removeOverLay() {
    _valueNotifier.value = ((OverLayType.none, null));
  }

  void dispose() {
    _valueNotifier.dispose();
  }
}

class _MessageText {
  final String? title;
  final String message;
  final MessageType messageType;
  _MessageText({
    this.title,
    required this.message,
    required this.messageType,
  });
}
