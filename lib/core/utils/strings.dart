import 'package:intl/intl.dart';

class Strings {
  static String delivery =
      Intl.message('The delivery app for Businesses.', locale: 'en');
  static String connectionError =
      Intl.message('Please check your internet connection', locale: 'en');
  static String fileSizeError =
      Intl.message('File size is greater than 2MB', locale: 'en');
  static String genericErrorMessage =
      Intl.message("An error occurred", locale: "en");
  static String mediaNotSupported =
      Intl.message("Media not supported", locale: "en");
  static String pp = Intl.message("Privacy Policy", locale: "en");
  static String cookie = Intl.message("Cookie use", locale: "en");
  static String proceed = Intl.message("Proceed", locale: "en");
  static String serverError =
      Intl.message("A server error occurred", locale: "en");
  static String tandt = Intl.message(" Terms of service", locale: "en");
  static String timeout =
      Intl.message("Your connection timed out", locale: 'en');
  static String disclaimer1 =
      Intl.message("By signing up you agree to our", locale: "en");
  static String sessionExpired = Intl.message('Session Expired', locale: 'en');
  static String sessionExpiredSub = Intl.message(
      'Your session has expired, please login again.',
      locale: 'en');
}
