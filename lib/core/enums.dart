// ignore_for_file: constant_identifier_names

enum LoadState { loading, idle, success, error, loadmore, done }

enum LoginLoadState { loading, idle, success, error, unverified }

enum CurrentState { loggedIn, onboarded, initial }

enum OverLayType { loader, message, none }

enum MessageType { error, success }

enum Own { yes, no }

enum VerifyType { phone, email }

enum ImageType { single, multi }

enum PermissionStatus {
  denied,
  deniedForever,
  whileInUse,
  always,
  unableToDetermine,
  initial,
}

enum HomeSessionState { logout, initial }
