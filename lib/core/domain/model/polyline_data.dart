import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class PolyLineData {
  final String distance;
  final String duration;
  final List<PointLatLng> points;
  final String destinationAddress;
  PolyLineData({
    required this.distance,
    required this.duration,
    required this.points,
    required this.destinationAddress,
  });
}
