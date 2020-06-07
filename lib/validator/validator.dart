import 'package:regexpattern/regexpattern.dart';

class Valid {
  Valid._();
  static bool isEmail(String email) {
    return RegexValidation.hasMatch(email, RegexPattern.email);
  }

  static bool isUserNamee(String userName){
    return RegexValidation.hasMatch(userName, RegexPattern.username);
  }

  static bool isPhoneNumber(String email) {
    return RegexValidation.hasMatch(email, RegexPattern.phone);
  }

  static bool isPassword(String email) {
    return RegexValidation.hasMatch(email, RegexPattern.passwordEasy);
  }
}
