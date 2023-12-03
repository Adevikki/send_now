import 'package:json_annotation/json_annotation.dart';
part 'get_place_details.g.dart';

@JsonSerializable()
class GetPlaceDetails {
  GetPlaceDetails({
    this.result,
    this.status,
  });
  final PlaceDetail? result;
  final String? status;

  Map<String, dynamic> toJson() => _$GetPlaceDetailsToJson(this);

  factory GetPlaceDetails.fromJson(Map<String, dynamic> json) =>
      _$GetPlaceDetailsFromJson(json);
}

@JsonSerializable()
class PlaceDetail {
  PlaceDetail({
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.vicinity,
    this.addressComponents,
  });

  @JsonKey(name: "address_components")
  final List<AddressComponent>? addressComponents;
  @JsonKey(name: "formatted_address")
  final String? formattedAddress;
  final Geometry? geometry;
  @JsonKey(name: "place_id")
  final String? placeId;
  final String? vicinity;

  Map<String, dynamic> toJson() => _$PlaceDetailToJson(this);

  factory PlaceDetail.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailFromJson(json);
}

@JsonSerializable()
class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  final Location location;
  final Viewport viewport;

  Map<String, dynamic> toJson() => _$GeometryToJson(this);

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

@JsonSerializable()
class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@JsonSerializable()
class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  final Location northeast;
  final Location southwest;

  Map<String, dynamic> toJson() => _$ViewportToJson(this);

  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);
}

@JsonSerializable()
class AddressComponent {
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  @JsonKey(name: "long_name")
  final String longName;
  @JsonKey(name: "short_name")
  final String shortName;
  final List<String> types;

  Map<String, dynamic> toJson() => _$AddressComponentToJson(this);

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentFromJson(json);
}
