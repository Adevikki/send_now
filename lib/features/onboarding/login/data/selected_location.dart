class SelectedLocation {
  final String address;
  final double longitude;
  final double latitude;
  final String placeID;
  final String? duration;
  final String? distance;
  SelectedLocation({
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.placeID,
    this.duration,
    this.distance,
  });
}
