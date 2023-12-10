import 'package:ofma_app/models/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static User? get user {
    final jsonUser = _preferences.getString('user');
    return (jsonUser == null) ? null : User.fromJson(jsonUser);
  }

  static set user(User? newUser) {
    if (newUser == null) return;
    _preferences.setString('user', newUser.toJson());
  }

  static String? get token => _preferences.getString('token');

  static set token(String? token) {
    if (token == null) return;
    _preferences.setString('token', token);
  }

  static clear() {
    _preferences.clear();
  }
}
