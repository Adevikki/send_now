import 'package:flutter/material.dart';
import 'package:send_now_test/features/home/home_page.dart';
import 'package:send_now_test/features/onboarding/splash.dart';

import '../../../features/onboarding/login/presentation/pages/login_page.dart';
import '../../../presentation/general_widgets/navbar.dart';
import 'route_lists.dart';

class SendNowRoutes {
  static Map<String, WidgetBuilder> getAll(BuildContext context) {
    return {
      RouteList.splash: (context) => const Splash(),
      RouteList.landingPage: (context) => const LandingPage(),
      RouteList.homePage: (context) => const HomePage(),
      RouteList.navBar: (context) => const NavBar(),
    };
  }
}
