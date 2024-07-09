

import 'package:shared_preferences/shared_preferences.dart';

class Sharepreff {
  static SharedPreferences? _shareprf;
  static String userNameKey = "username";
  static String userEmailKey = "useremail";
  static String userAgeKey = "userage";
  static String userPhoneKey = "userphone";

  init() async {
    _shareprf ??= await SharedPreferences.getInstance();
  }

  String get userName => _shareprf!.getString(userNameKey) ?? "";
  String get userEmail => _shareprf!.getString(userEmailKey) ?? "";
  int get userAge => _shareprf!.getInt(userAgeKey) ?? 0;
  int get userphone => _shareprf!.getInt(userPhoneKey) ?? 0;

  set userName(String value) {
    _shareprf!.setString(userNameKey, value);
  }

  set userEmail(String value) {
    _shareprf!.setString(userEmailKey, value);
  }

  set userAge(int value) {
    _shareprf!.setInt(userNameKey, value);
  }

  set userphone(int value) {
    _shareprf!.setInt(userNameKey, value);
  }
}

final sharedpref = Sharepreff();
