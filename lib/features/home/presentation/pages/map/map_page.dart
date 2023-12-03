import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/utils/colors.dart';
import 'package:send_now_test/features/home/presentation/pages/map/where.dart';
import 'package:send_now_test/features/onboarding/login/presentation/notifiers/login_notifier.dart';

import '../../../../../presentation/general_widgets/custom_app_bar.dart';

class MapScreen extends ConsumerStatefulWidget {
  final String receiptNumber;

  const MapScreen({Key? key, required this.receiptNumber}) : super(key: key);

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late DraggableScrollableController dragScrollController;
  @override
  void initState() {
    super.initState();
    dragScrollController = DraggableScrollableController()
      ..addListener(() {
        _setDragSize();
      });
  }

  _setDragSize() {
    final notifier = ref.read(loginNotifier.notifier);
    notifier.changeDragSize(dragScrollController.size);
  }

  @override
  Widget build(BuildContext context) {
    final userLocation = ref.watch(loginNotifier.select((v) => v.userLocation));
    final draggableSize = ref.watch(loginNotifier.select((v) => v.dragSize));
    LatLng mapCenter = LatLng(userLocation.latitude, userLocation.longitude);

    CameraPosition initialPosition =
        CameraPosition(target: mapCenter, zoom: 15, tilt: 0, bearing: 0);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(initialCameraPosition: initialPosition),
          if (draggableSize != 0.90)
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomAppBar(
                      title: 'Tracking Details',
                      onBackPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        Container(
                          height: 88,
                          decoration: BoxDecoration(
                            color: SendNowColors.yellow,
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 68,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.receiptNumber,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: SendNowColors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          WhereAreYouGoing(
            dragScrollController: dragScrollController,
          ),
        ],
      ),
    );
  }
}
