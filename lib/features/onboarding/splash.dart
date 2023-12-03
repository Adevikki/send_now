import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/enums.dart';
import '../../core/services/navigation/route_lists.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/images.dart';
import '../../data/user_repository_impl.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    Future.delayed(const Duration(seconds: 2), () {
      var data = ref.read(userRepository).getCurrentState();
      return switch (data) {
        CurrentState.loggedIn =>
          Navigator.pushReplacementNamed(context, RouteList.landingPage),
        _ => Navigator.pushReplacementNamed(context, RouteList.landingPage),
      };
    });
  }

  //  userRepository.saveCurrentState(CurrentState.loggedIn);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: SendNowColors.dark,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: SendNowColors.yellow,
      body: Center(
          child: Image.asset(
        AppImages.splash,
        height: 208,
        width: 208,
      )),
    );
  }
}
