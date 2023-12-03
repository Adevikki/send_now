// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_place_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPlaceDetails _$GetPlaceDetailsFromJson(Map<String, dynamic> json) =>
    GetPlaceDetails(
      result: json['result'] == null
          ? null
          : PlaceDetail.fromJson(json['result'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$GetPlaceDetailsToJson(GetPlaceDetails instance) =>
    <String, dynamic>{
      'result': instance.result,
      'status': instance.status,
    };

PlaceDetail _$PlaceDetailFromJson(Map<String, dynamic> json) => PlaceDetail(
      formattedAddress: json['formatted_address'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      placeId: json['place_id'] as String?,
      vicinity: json['vicinity'] as String?,
      addressComponents: (json['address_components'] as List<dynamic>?)
          ?.map((e) => AddressComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceDetailToJson(PlaceDetail instance) =>
    <String, dynamic>{
      'address_components': instance.addressComponents,
      'formatted_address': instance.formattedAddress,
      'geometry': instance.geometry,
      'place_id': instance.placeId,
      'vicinity': instance.vicinity,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      viewport: Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
      'viewport': instance.viewport,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Viewport _$ViewportFromJson(Map<String, dynamic> json) => Viewport(
      northeast: Location.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest: Location.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewportToJson(Viewport instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

AddressComponent _$AddressComponentFromJson(Map<String, dynamic> json) =>
    AddressComponent(
      longName: json['long_name'] as String,
      shortName: json['short_name'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AddressComponentToJson(AddressComponent instance) =>
    <String, dynamic>{
      'long_name': instance.longName,
      'short_name': instance.shortName,
      'types': instance.types,
    };
