import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/enums.dart';
import 'package:send_now_test/core/services/location/location_service_impl.dart';
import 'package:send_now_test/features/onboarding/login/presentation/notifiers/login_notifier.dart';
import 'package:send_now_test/presentation/general_widgets/error_modal.dart';
import '../../../../../core/services/navigation/route_lists.dart';
import '../../../../../core/utils/colors.dart';
import '../../data/landing_page_model.dart';
import 'login_with_google.dart';
import 'dont_have_account.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int page = 0;
  bool _swipingFromPageView = true;

  final List<LandingPageModel> _items = [
    LandingPageModel(
      title: 'Welcome to E-Bikes',
      description: 'Buying Electric bikes just got a lot easier, Try us today.',
    ),
    LandingPageModel(
      title: 'Welcome to E-Bikes',
      description: 'Buying Electric bikes just got a lot easier, Try us today.',
    ),
    LandingPageModel(
      title: 'Welcome to E-Bikes',
      description: 'Buying Electric bikes just got a lot easier, Try us today.',
    )
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        // viewportFraction: 0.5,
        );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((status) {
        _animateCurrentPage(status);
      });
    _forwardAnimation();
  }

  void _animateCurrentPage(AnimationStatus status) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (status == AnimationStatus.completed) {
        if (page == (_items.length - 1)) {
          page = 0;
        } else {
          page += 1;
        }
        if (page == 0) {
          _pageController.jumpTo(
            0,
          );
        } else {
          _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
          );
        }
        _resetAnimation();
      }
    });
  }

  void _goToNextpage() {
    _swipingFromPageView = false;
    if (page == (_items.length - 1)) {
      _animationController.stop();
      Navigator.pushReplacementNamed(context, RouteList.navBar);
    } else {
      page += 1;
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );
      if (page == (_items.length - 1)) _animationController.stop();
    }
  }

  void _forwardAnimation() {
    _animationController.forward();
  }

  void _resetAnimation() {
    _animationController
      ..reset()
      ..forward();
  }

  void _changePage(int value) => setState(() {
        page = value;
        if (_swipingFromPageView) _resetAnimation();
        _swipingFromPageView = true;
      });

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: const Color.fromARGB(255, 237, 217, 146),
  //     body: SafeArea(
  //       child: AnimatedBuilder(
  //         animation: _animationController,
  //         builder: (context, child) {
  //           return Stack(
  //             children: [
  //               Positioned(
  //                 top: 0,
  //                 left: 0,
  //                 right: 0,
  //                 child: Image.asset(
  //                   "assets/images/stacked_color.png",
  //                   fit: BoxFit.contain,
  //                   // height: 120,
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 0,
  //                 right: 0,
  //                 child: Image.asset(
  //                   "assets/images/top_image_end.png",
  //                   fit: BoxFit.cover,
  //                   height: 120, // Adjust the height as needed
  //                 ),
  //               ),
  //               SingleChildScrollView(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child:
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginNotifier, (previous, next) async {
      if (next.permissionStatus == PermissionStatus.deniedForever) {
        showErrorSnack(
          message: 'We need to access your location for verification purposes',
          context: context,
          onDismissed: () {
            ref.read(locationService).openSettings().then((value) {
              if (value) {
                Navigator.pop(context);
                ref.read(loginNotifier.notifier).getLocation();
              }
            });
          },
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 217, 146),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/stacked_color.png",
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.64,
                          child: PageView.builder(
                            padEnds: true,
                            onPageChanged: _changePage,
                            controller: _pageController,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final item = _items[index];

                              return Column(
                                children: [
                                  const SizedBox(height: 30),
                                  AspectRatio(
                                    aspectRatio: 1.17,
                                    child: Image.asset(
                                      "assets/images/delivery_image.png",
                                    ),
                                  ),
                                  Text(
                                    item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: SendNowColors.primaryFill,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 18),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 50,
                                      right: 50,
                                    ),
                                    child: Text(
                                      item.description,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: SendNowColors.primarylight,
                                          ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _items.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == page
                                    ? SendNowColors.grey
                                    : SendNowColors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        GoogleLoginButton(
                          onTap: _goToNextpage,
                        ),
                        const SizedBox(height: 30),
                        SignUpRow(
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/line_stacked_image.svg',
                    // height: 20,
                    // width: 20,
                    // fit: BoxFit.fitWidth,
                  ),
                  SvgPicture.asset(
                    'assets/svgs/line_stacked_image.svg',
                    // height: 20,
                    // width: 20,
                    // fit: BoxFit.fitWidth,
                  ),
                  SvgPicture.asset(
                    'assets/svgs/line_stacked_image.svg',
                    // height: 20,
                    // width: 20,
                    // fit: BoxFit.fitWidth,
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
