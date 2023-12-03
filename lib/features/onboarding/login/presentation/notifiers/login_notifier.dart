import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/domain/model/places_response.dart';
import 'package:send_now_test/core/domain/model/repositories/user_repository.dart';
import 'package:send_now_test/core/enums.dart';
import 'package:send_now_test/core/services/location/location_service.dart';
import 'package:send_now_test/core/services/location/location_service_impl.dart';
import 'package:send_now_test/data/user_repository_impl.dart';
import 'package:send_now_test/features/onboarding/login/data/selected_location.dart';
import 'package:send_now_test/features/onboarding/login/presentation/notifiers/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this.userRepository, this.ref, this.locationService)
      : super(LoginState.initial(ref)) {
    getLocation();
  }

  final UserRepository userRepository;
  final Ref ref;
  final LocationService locationService;

  void selectLocation(SelectedLocation location) {
    state = state.copyWith(
      selectedLocation: location,
    );
  }

  Future<void> getLocation() async {
    try {
      final value = await locationService.checkPermission();
      if (value == PermissionStatus.deniedForever) {
        state = state.copyWith(
          permissionStatus: value,
        );
        state = state.copyWith(
          permissionStatus: PermissionStatus.initial,
        );
        return;
      }
      if (value != PermissionStatus.denied &&
          value != PermissionStatus.unableToDetermine) {
        final place = await locationService.getCurrentPosition();
        final location = SelectedLocation(
          address:
              "${place.address}, ${place.city}, ${place.state},${place.zipcode}.",
          longitude: place.longitude,
          latitude: place.latitude,
          placeID: place.zipcode,
        );
        if (mounted) {
          state = state.copyWith(
            userLocation: place,
            permissionStatus: value,
            selectedLocation: location,
          );
        }
        userRepository.setUserLastPosition(place);
      } else {
        requestPermission();
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: "$e",
      );
    }
  }

  changeDragSize(double size) {
    state = state.copyWith(dragSize: size);
  }

  void searchPlace({required String query}) async {
    try {
      final res = await locationService.getPlace(query);
      state = state.copyWith(
        searchResults: res.address,
      );
    } catch (_) {}
  }

  void getPlaceDetails(Address address, void Function() onSuccess) async {
    if (state.selectedLocation != null &&
        state.selectedLocation?.placeID == address.placeId) {
      return;
    }
    state = state.copyWith(getPlaceLoadState: LoadState.loading);
    try {
      final res = await locationService.getPlaceDetails(address.placeId);

      state = state.copyWith(
        searchedPlaceDetails: res.result,
        getPlaceLoadState: LoadState.success,
      );
      final location = SelectedLocation(
        address: res.result?.formattedAddress ?? "",
        longitude: res.result?.geometry?.location.lng ?? 0,
        latitude: res.result?.geometry?.location.lat ?? 0,
        placeID: address.placeId,
      );
      selectLocation(location);
      onSuccess();
    } catch (e) {
      state = state.copyWith(getPlaceLoadState: LoadState.error);
    }
  }

  void requestPermission() async {
    try {
      final value = await locationService.requestPermission();
      if (value == PermissionStatus.deniedForever) {
        state = state.copyWith(permissionStatus: value);
        state = state.copyWith(permissionStatus: PermissionStatus.initial);
        return;
      }
      if (value == PermissionStatus.denied) {
        requestPermission();
        return;
      }
      if (value != PermissionStatus.denied &&
          value != PermissionStatus.unableToDetermine) {
        final data = await locationService.getCurrentPosition();
        state = state.copyWith(userLocation: data, permissionStatus: value);
      }
      return;
    } catch (e) {
      state = state.copyWith(
        errorMessage: "$e",
      );
    }
  }
}

final loginNotifier = StateNotifierProvider<LoginNotifier, LoginState>((_) {
  return LoginNotifier(_.read(userRepository), _, _.read(locationService));
});
