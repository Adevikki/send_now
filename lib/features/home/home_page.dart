import 'package:flutter/material.dart';

import '../../presentation/widgets/header.dart';
import 'presentation/pages/track_order/track_orders_page.dart';
import 'presentation/pages/check_order/check_order_page.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, this.onTap, this.onResetState, this.showYourOrderWidget});
  final void Function()? onTap;
  final VoidCallback? onResetState;
  final bool? showYourOrderWidget;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int page = 0;
  int index = 0;
  bool _swipingFromPageView = true;
  late bool _showYourOrderWidget = true;

  @override
  void initState() {
    super.initState();
    _showYourOrderWidget = widget.showYourOrderWidget!;
    _pageController = PageController(
      viewportFraction: 0.75,
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _forwardAnimation();
  }

  void resetState() {
    setState(() {
      _showYourOrderWidget = true;
      page = 0;
    });
  }

  // void _animateCurrentPage(AnimationStatus status) {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     if (status == AnimationStatus.completed) {
  //       if (page == 0) {
  //         _pageController.jumpTo(0);
  //       } else {
  //         _pageController.animateToPage(
  //           page,
  //           duration: const Duration(milliseconds: 500),
  //           curve: Curves.linearToEaseOut,
  //         );
  //       }
  //       _resetAnimation();
  //     }
  //   });
  // }

  void _forwardAnimation() {
    _animationController.forward();
  }

  void _changePage(int value) => setState(() {
        page = value;
        if (_swipingFromPageView) _resetAnimation();
        _swipingFromPageView = true;
      });

  void _resetAnimation() {
    _animationController
      ..reset()
      ..forward();
  }

  void _onOrderClicked() {
    setState(() {
      _showYourOrderWidget = false;
    });
  }

  void _onHeaderClicked() {
    setState(() {
      _showYourOrderWidget = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(
              onTap: _onHeaderClicked,
              showArrow: !_showYourOrderWidget,
            ),
            const SizedBox(height: 10),
            _showYourOrderWidget
                ? Expanded(
                    child: CheckOrderPage(
                      pageController: _pageController,
                      currentPage: page,
                      onPageChanged: _changePage,
                      onOrderClicked: _onOrderClicked,
                    ),
                  )
                : TrackOrders()
          ],
        ),
      ),
    );
  }
}
