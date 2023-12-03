import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/utils/dimensions.dart';
import 'package:send_now_test/features/home/presentation/pages/map/package_arrival_draggable_sheet.dart';
import 'package:send_now_test/features/onboarding/login/presentation/notifiers/login_notifier.dart';

class WhereAreYouGoing extends ConsumerStatefulWidget {
  final DraggableScrollableController dragScrollController;
  const WhereAreYouGoing({Key? key, required this.dragScrollController})
      : super(key: key);

  @override
  ConsumerState<WhereAreYouGoing> createState() => _WhereAreYouGoingState();
}

class _WhereAreYouGoingState extends ConsumerState<WhereAreYouGoing> {
  bool _isFullyOpen = false;

  @override
  Widget build(BuildContext context) {
    final draggableSize = ref.watch(loginNotifier.select((v) => v.dragSize));

    return DraggableScrollableSheet(
      controller: widget.dragScrollController,
      snap: true,
      maxChildSize: 0.88,
      minChildSize: 0.15,
      initialChildSize: draggableSize,
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            setState(() {
              _isFullyOpen = notification.extent == 1.0;
            });
            return true;
          },
          child: Stack(
            children: [
              if (_isFullyOpen)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.medium,
                    vertical: Dimensions.big,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: Tween<double>(begin: 0, end: 1)
                                  .animate(animation),
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: const Offset(0, 0),
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: draggableSize == 0.50
                              ? const SizedBox()
                              : PackageArrival(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
