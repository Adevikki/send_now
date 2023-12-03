import 'package:send_now_test/core/services/location/location_service.dart';

import '../../../enums.dart';

abstract interface class UserRepository {
  void saveCurrentState(CurrentState val);
  CurrentState getCurrentState();
    AppPosition getUserLastPosition();
  void setUserLastPosition(AppPosition val);
}
