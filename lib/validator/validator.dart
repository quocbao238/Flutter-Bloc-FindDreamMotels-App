import 'package:regexpattern/regexpattern.dart';

class Valid {
  Valid._();
  static bool isEmail(String email) {
    return RegexValidation.hasMatch(email, RegexPattern.email);
  }

  static bool isPhoneNumber(String email) {
    return RegexValidation.hasMatch(email, RegexPattern.phone);
  }

  static bool password(String email) {
    return RegexValidation.hasMatch(email, RegexPattern.passwordEasy);
  }
}
