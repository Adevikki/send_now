import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:send_now_test/core/domain/model/get_place_details.dart';
import 'package:send_now_test/core/domain/model/places_response.dart';
import 'package:send_now_test/core/enums.dart';
import 'package:send_now_test/core/services/location/location_service.dart';
import 'package:send_now_test/data/user_repository_impl.dart';
import 'package:send_now_test/features/onboarding/login/data/selected_location.dart';

class LoginState {
  final LoginLoadState loadState;
  final bool isInputValid;
  final bool isPhoneValid;
  final AppPosition userLocation;
  final PlaceDetail? searchedPlaceDetails;
  final PermissionStatus permissionStatus;
  final List<Address> searchResults;
  final Address? selectedAddress;
  final LoadState getPlaceLoadState;
  final SelectedLocation? selectedLocation;
  final double dragSize;

  LoginState({
    required this.loadState,
    required this.isInputValid,
    required this.isPhoneValid,
    required this.userLocation,
    this.selectedLocation,
    this.searchedPlaceDetails,
    this.selectedAddress,
    required this.permissionStatus,
    required this.searchResults,
    required this.getPlaceLoadState,
    required this.dragSize,
  });

  factory LoginState.initial(Ref ref) {
    return LoginState(
      loadState: LoginLoadState.idle,
      isInputValid: false,
      isPhoneValid: false,
      userLocation: ref.read(userRepository).getUserLastPosition(),
      permissionStatus: PermissionStatus.denied,
      getPlaceLoadState: LoadState.idle,
      searchResults: [],
      dragSize: 0.16,
    );
  }

  LoginState copyWith({
    LoginLoadState? loadState,
    bool? isInputValid,
    bool? isPhoneValid,
    AppPosition? userLocation,
    SelectedLocation? selectedLocation,
    PlaceDetail? searchedPlaceDetails,
    LoadState? getPlaceLoadState,
    PermissionStatus? permissionStatus,
    List<Address>? searchResults,
    String? errorMessage,
    Address? selectedAddress,
    double? dragSize,
  }) {
    return LoginState(
      loadState: loadState ?? this.loadState,
      isInputValid: isInputValid ?? this.isInputValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      getPlaceLoadState: getPlaceLoadState ?? this.getPlaceLoadState,
      userLocation: userLocation ?? this.userLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      searchedPlaceDetails: searchedPlaceDetails ?? this.searchedPlaceDetails,
      permissionStatus: permissionStatus ?? this.permissionStatus,
      searchResults: searchResults ?? this.searchResults,
      dragSize: dragSize ?? this.dragSize,
    );
  }
}
