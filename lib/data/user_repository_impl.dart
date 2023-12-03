
import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/services/location/location_service.dart';

import '../core/domain/model/repositories/user_repository.dart';
import '../core/enums.dart';
import '../core/services/local_database/hive_keys.dart';
import '../core/services/local_database/local_storage.dart';
import '../core/services/local_database/local_storage_impl.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalStorage _storage;

  UserRepositoryImpl(this._storage);

  @override
  void saveCurrentState(CurrentState val) async {
    await _storage.put(HiveKeys.currentState, val.name);
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
  AppPosition getUserLastPosition() {
    final response = _storage.get(HiveKeys.userLastPositon) ??
        AppPosition(
          longitude: -122.08832357078792,
          latitude: 37.43296265331129,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 1,
          heading: 1,
          speed: 1,
          speedAccuracy: 0,
          address: "",
          city: "",
          country: "",
          state: "",
          zipcode: "",
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
    var position =
        response is String ? AppPosition.fromJson(response) : response;
    return position;
  }

  @override
  void setUserLastPosition(AppPosition val) async {
    await _storage.put(HiveKeys.userLastPositon, json.encode(val));
  }

}

final userRepository = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(ref.read(localDB)),
);
