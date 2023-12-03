import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/utils/colors.dart';

import 'core/services/local_database/hive_keys.dart';
import 'core/services/navigation/navigation_route.dart';
import 'presentation/general_widgets/app_overlay.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.appBox);
  runApp(const ProviderScope(child: SendNow()));
}

class SendNow extends StatefulWidget {
  const SendNow({super.key});

  @override
  State<SendNow> createState() => _SendNowState();
}

class _SendNowState extends State<SendNow> {
  final _controller = OverLayLoaderController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: AppOverLay(
        controller: _controller,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CarryNa Dispatcher',
          theme: ThemeData(
            fontFamily: 'Product Sans',
            colorScheme:
                ColorScheme.fromSeed(seedColor: SendNowColors.primaryColor),
            useMaterial3: true,
          ),
          routes: SendNowRoutes.getAll(context),
        ),
      ),
    );
  }
}
