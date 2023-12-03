import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/enums.dart';
import 'package:uuid/uuid.dart';
import '../../config/response/base_response.dart';
import '../../domain/model/get_place_details.dart';
import '../../domain/model/places_response.dart';
import '../../domain/model/polyline_data.dart';
import '../../utils/strings.dart';
import '../local_database/hive_keys.dart';
import '../local_database/local_storage.dart';
import '../local_database/local_storage_impl.dart';
import '../places_client/places_client.dart';
import 'location_service.dart';

class LocationServiceImpl implements LocationService {
  final GeolocatorPlatform geolocator;
  final PlacesClient _placesClient;
  final Uuid uuid;
  final LocalStorage _storage;
  final PolylinePoints polylinePoints;
  LocationServiceImpl(
    this.geolocator,
    this._placesClient,
    this.uuid,
    this._storage,
    this.polylinePoints,
  );
  @override
  Future<PermissionStatus> checkPermission() async {
    try {
      final location = await geolocator.checkPermission();
      return _getPermission(location);
    } catch (e) {
      throw Future.error('Location permissions are denied');
    }
  }

  @override
  CurrentState getCurrentState() {
    switch (_storage.get(HiveKeys.currentState) ?? CurrentState.initial.name) {
      case "onboarded":
        return CurrentState.onboarded;
      case "loggedIn":
        return CurrentState.loggedIn;
      default:
        return CurrentState.initial;
    }
  }

  @override
  Future<AppPosition> getCurrentPosition() async {
    try {
      final location = await geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best),
      );
      return AppPosition(
        longitude: location.longitude,
        latitude: location.latitude,
        timestamp: location.timestamp,
        accuracy: location.accuracy,
        altitude: location.altitude,
        heading: location.heading,
        speed: location.speed,
        speedAccuracy: location.speedAccuracy,
        address: "",
        city: "",
        country: "",
        state: "",
        zipcode: "",
        altitudeAccuracy: location.altitudeAccuracy,
        headingAccuracy: location.headingAccuracy,
      );
    } catch (e) {
      throw Future.error('Location permissions are denied');
    }
  }

  PermissionStatus _getPermission(LocationPermission permissionstatus) {
    Map<LocationPermission, PermissionStatus> permission = {
      LocationPermission.always: PermissionStatus.always,
      LocationPermission.denied: PermissionStatus.denied,
      LocationPermission.deniedForever: PermissionStatus.deniedForever,
      LocationPermission.unableToDetermine: PermissionStatus.unableToDetermine,
      LocationPermission.whileInUse: PermissionStatus.whileInUse,
    };

    return permission[permissionstatus] as PermissionStatus;
  }

  @override
  Future<PermissionStatus> requestPermission() async {
    try {
      final location = await geolocator.requestPermission();
      return _getPermission(location);
    } catch (e) {
      throw Future.error('Location permissions are denied');
    }
  }

  @override
  Future<PlacesResponse> getPlace(String query) async {
    final sessionToken = uuid.v4();
    try {
      final res = await _placesClient.getPlace({
        "input": query,
        "sessiontoken": sessionToken,
      });
      _storage.put(HiveKeys.sessionToken, sessionToken);
      return res;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> openSettings() {
    return geolocator.openLocationSettings();
  }

  @override
  Future<GetPlaceDetails> getPlaceDetails(String placeId) async {
    try {
      final sessionToken = _storage.get(HiveKeys.sessionToken) ?? "";
      final res = await _placesClient.getPlaceDetails({
        "place_id": placeId,
        "sessiontoken": sessionToken,
      });
      return res;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<BaseResponse<PolyLineData>> getCoordinates({
    required PointLatLng origin,
    required PointLatLng destination,
  }) async {
    var params = {
      "origin": "${origin.latitude},${origin.longitude}",
      "destination": "${destination.latitude},${destination.longitude}",
      "mode": TravelMode.driving,
    };
    try {
      var parsedJson = await _placesClient.getDrivingDistance(params);
      if (parsedJson["status"]?.toLowerCase() == "ok" &&
          parsedJson["routes"] != null &&
          parsedJson["routes"].isNotEmpty) {
        final distance = parsedJson["routes"][0]["legs"][0]["distance"]["text"];
        final duration = parsedJson["routes"][0]["legs"][0]["duration"]["text"];
        final points = polylinePoints.decodePolyline(
          parsedJson["routes"][0]["overview_polyline"]["points"],
        );
        final endAddress = parsedJson["routes"][0]["legs"][0]["end_address"];
        return BaseResponse(
            status: true,
            data: PolyLineData(
              distance: distance,
              duration: duration,
              points: points,
              destinationAddress: endAddress,
            ));
      }
      return const BaseResponse(
        status: true,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown) {
        return const BaseResponse(
            status: false, message: "Please check your internet connection");
      } else if (e.type == DioExceptionType.badResponse) {
        return BaseResponse(
          status: false,
          message:
              e.response?.data["error_message"] ?? Strings.genericErrorMessage,
        );
      }
      return Future.error(e);
    }
  }
}

final locator =
    Provider<GeolocatorPlatform>((ref) => GeolocatorPlatform.instance);
final locationService = Provider(
  (ref) => LocationServiceImpl(
    ref.read(locator),
    ref.read(placesClient),
    const Uuid(),
    ref.read(localDB),
    PolylinePoints(),
  ),
);
