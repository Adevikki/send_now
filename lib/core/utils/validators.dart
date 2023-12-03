import 'package:send_now_test/core/extensions/validation_extentions.dart';

/// A collection of common validators that can be reused
class Validators {
  static final emailPattern = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
    r"[a-zA-Z0-9])?)+$",
  );

  static final phonePattern =
      RegExp("^(\\+234[7-9]|234[7-9]|08|09|07|[7-9])\\d{9}\$");

  static Validator notEmpty() {
    return (String? value) {
      return (value?.isEmpty ?? true) ? "This field can not be empty." : null;
    };
  }

  static Validator username() {
    return (String? value) {
      if ((value?.isEmpty ?? true)) {
        return "This field can not be empty.";
      } else if (value!.contains(" ")) {
        return "Username can not contain spaces";
      } else if (value.containsUsernameSpecial()) {
        return "Username can only contain letters, numbers, dashes, full stop, and underscores";
      }
      return null;
    };
  }

  static Validator confirmPass(String val1, String val2) {
    return (String? value) {
      if (val1 != val2) {
        return "Passwords do not match";
      } else {
        return null;
      }
    };
  }

  static Validator phone([String? text]) {
    return (String? value) {
      if (value == null) {
        return null;
      }
      return !phonePattern.hasMatch(value)
          ? (text ?? "Invalid phone number")
          : null;
    };
  }

  static Validator date() {
    return (String? input) {
      // Remove any non-numeric characters from the input
      String? numericInput = input!.replaceAll(RegExp(r'\D'), '');

      // Validate the length of the numeric input
      if (numericInput.length != 8) {
        return 'Invalid date';
      }

      // Extract the day, month, and year components
      int? day = int.tryParse(numericInput.substring(0, 2));
      int? month = int.tryParse(numericInput.substring(2, 4));
      int? year = int.tryParse(numericInput.substring(4, 8));
      // Validate the day, month, and year components
      if (day == null || month == null || year == null) {
        return 'Invalid date';
      }

      if (day > 29 && month == 2) {
        return 'Invalid February date';
      }

      // Validate the date components
      if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1900) {
        return 'Invalid date';
      }

      // Ensure that the year is not less than 5 years ago
      DateTime now = DateTime.now();
      DateTime inputDate = DateTime(year, month, day);
      if (inputDate.isAfter(now.subtract(const Duration(days: 365 * 5)))) {
        return 'You must be at least 5 years old to register.';
      }

      // Additional validation logic can be added if needed

      return null;
    };
  }

  static Validator name() {
    return (String? value) {
      if (value!.isEmpty) {
        return "Field cannot be empty.";
      }
      if (value.length < 2) {
        return "Name must be at least 2 characters";
      }

      return null;
    };
  }

  static Validator accountNumber() {
    return (String? value) {
      return (value!.length < 10) ? "Invalid account number." : null;
    };
  }

  static Validator minLength(int minLength) {
    return (String? value) {
      if ((value?.length ?? 0) < minLength) {
        return "Must contain a minimum of $minLength characters.";
      }
      return null;
    };
  }

  static bool isValid(String pin, String pin2) =>
      (pin.isNotEmpty && pin2.isNotEmpty && pin == pin2);
  static Validator matchPattern(Pattern pattern,
      [String? patternName, String? text]) {
    return (String? value) {
      if (value == null || (pattern.allMatches(value).isEmpty)) {
        return (text ?? "Please enter a valid ${patternName ?? "value"}.");
      }
      return null;
    };
  }

  static Validator email([String? text]) {
    return matchPattern(emailPattern, "email", text);
  }

  static Validator password([int minimumLength = 8]) => multiple(
        [
          containsUpper("Password"),
          containsLower("Password"),
          containsNumber("Password"),
          containsSpecialChar("Password"),
          minLength(minimumLength),
        ],
        shouldTrim: false,
      );

  static Validator containsUpper([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsUpper()) return null;
      return "${fieldName ?? 'Field'} must contain at least one uppercase character.";
    };
  }

  static Validator containsLower([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsLower()) return null;
      return "${fieldName ?? 'Field'} must contain at least one lowercase character.";
    };
  }

  static Validator containsNumber([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsNumber()) return null;
      return "${fieldName ?? 'Field'} must contain at least one number.";
    };
  }

  static Validator containsSpecialChar([String? fieldName]) {
    return (String? value) {
      if (value != null && value.containsSpecialChar()) return null;
      return "${fieldName ?? 'Field'} must contain at least one special character.";
    };
  }

  /// Creates a validator that if the combination of multiple validators.
  ///
  /// The provided validators are applied in the order in which
  /// they're specified in the list.
  static Validator multiple(
    List<Validator> validators, {
    bool shouldTrim = true,
  }) {
    return (String? value) {
      value = shouldTrim ? value?.trim() : value;
      for (Validator validator in validators) {
        if (validator(value) != null) {
          return validator(value);
        }
      }
      return null;
    };
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static validateCardNum() {
    return (String? input) {
      if (input == null || input.isEmpty) {
        return "This field is required";
      }
      input = getCleanedNumber(input);
      if (input.length < 8) {
        return "Card is invalid";
      }
      int sum = 0;
      int length = input.length;
      for (var i = 0; i < length; i++) {
        // get digits in reverse order
        int digit = int.parse(input[length - i - 1]);
        // every 2nd number multiply with 2
        if (i % 2 == 1) {
          digit *= 2;
        }
        sum += digit > 9 ? (digit - 9) : digit;
      }
      if (sum % 10 == 0) {
        return null;
      }
      return "Card is invalid";
    };
  }

  static validateCVV() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return "This field is required";
      }
      if (value.length < 3 || value.length > 3) {
        return "CVV is invalid";
      }
      return null;
    };
  }

  static Validator cardName() {
    return (String? value) {
      if (value!.isEmpty) {
        return "Field cannot be empty.";
      }
      if (!value.contains(" ")) {
        return "Seperate names with spaces";
      }
      return null;
    };
  }

  static validateDate() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return "This field is required";
      }
      int year;
      int month;
      if (value.contains(RegExp(r'(/)'))) {
        var split = value.split(RegExp(r'(/)'));

        month = int.parse(split[0]);
        year = int.parse(split[1]);
      } else {
        month = int.parse(value.substring(0, (value.length)));
        year = -1; // Lets use an invalid year intentionally
      }
      if ((month < 1) || (month > 12)) {
        // A valid month is between 1 (January) and 12 (December)
        return 'Expiry month is invalid';
      }

      if (!hasDateExpired(month, year)) {
        return "Card has expired";
      }
      return null;
    };
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}

typedef Validator = String? Function(String? value);
