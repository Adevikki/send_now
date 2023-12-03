import 'package:flutter/material.dart';
import 'package:send_now_test/data/model/track_model.dart';
import 'package:send_now_test/core/utils/colors.dart';
import 'package:send_now_test/features/home/presentation/pages/map/track_detail_card.dart';

class PackageArrival extends StatelessWidget {
  PackageArrival({Key? key}) : super(key: key);

  final List<TrackingInfo> trackingInfo = [
    TrackingInfo(
      icon: Icons.local_shipping,
      title: 'In Delivery',
      subtitle: 'Bali, Indonesia',
      trailing: '00.00 PM',
    ),
    TrackingInfo(
      icon: Icons.inbox_outlined,
      title: 'Transit - Sending City',
      subtitle: 'Jakarta, Indonesia',
      trailing: '21.00 PM',
    ),
    TrackingInfo(
      icon: Icons.account_box,
      title: 'Send From Sukabumi',
      subtitle: 'Sukabumi, Indonesia',
      trailing: '19.00 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: SizedBox(
            width: 48,
            child: Divider(
              height: 5,
              thickness: 4,
              color: Color(0xFFDBE2E9),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimate arrives in",
                        style: TextStyle(
                          color: Color(0XFF2E3E5C),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '2h 40m',
                        style: TextStyle(
                          color: Color(0XFF2E3E5C),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TrackDetailCard(),
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      Positioned.fill(
                        left: 28,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 155,
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Text(
                        "History",
                        style: TextStyle(
                          color: Color(0XFF2E3E5C),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: trackingInfo.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.only(bottom: 16),
                            leading: TrackingIcon(
                              icon: trackingInfo[index].icon,
                              isFirst: index == 0,
                            ),
                            title: Text(
                              trackingInfo[index].title,
                              style: const TextStyle(
                                color: Color(0XFF1E3354),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              trackingInfo[index].subtitle,
                              style: const TextStyle(
                                color: Color(0XFF7A809D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: Text(
                              trackingInfo[index].trailing,
                              style: const TextStyle(
                                color: Color(0XFF7A809D),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TrackingIcon extends StatelessWidget {
  final IconData icon;
  final bool isFirst;

  const TrackingIcon({
    required this.icon,
    required this.isFirst,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFirst ? SendNowColors.yellow : SendNowColors.greyBorder,
          ),
        ),
        Icon(
          icon,
          color: Colors.black,
        ),
      ],
    );
  }
}
