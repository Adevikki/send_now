import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkDisplay extends StatelessWidget {
  const CachedNetworkDisplay({
    Key? key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.borderRadiusGeometry,
  }) : super(key: key);
  final String imageUrl;
  final BoxFit boxFit;
  final double? height, width;
  final BorderRadiusGeometry? borderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadiusGeometry ?? BorderRadius.circular(15),
      child: switch (imageUrl.isEmpty) {
        true => Container(
            height: height,
            width: width,
            color: Colors.grey.shade300,
          ),
        _ => CachedNetworkImage(
            // memCacheHeight: height?.round(),
            // memCacheWidth: width?.round(),
            progressIndicatorBuilder: (context, url, progress) {
              return AnimatedOpacity(
                opacity: 0.2,
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.cover,
                ),
              );
            },
            height: height,
            width: width,
            fit: boxFit,
            imageUrl: imageUrl,
          ),
      },
    );
  }
}

class CachedNetworkProfile extends StatelessWidget {
  const CachedNetworkProfile({
    Key? key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.borderRadiusGeometry,
  }) : super(key: key);
  final String imageUrl;
  final BoxFit boxFit;
  final double? height, width;
  final BorderRadiusGeometry? borderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadiusGeometry ?? BorderRadius.circular(60),
      child: switch (imageUrl.isEmpty) {
        true => Container(
            height: height,
            width: width,
            color: Colors.grey.shade300,
          ),
        _ => CachedNetworkImage(
            // memCacheHeight: height?.round(),
            // memCacheWidth: width?.round(),
            progressIndicatorBuilder: (context, url, progress) {
              return AnimatedOpacity(
                opacity: 0.2,
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.cover,
                ),
              );
            },
            height: height,
            width: width,
            fit: boxFit,
            imageUrl: imageUrl,
          ),
      },
    );
  }
}
