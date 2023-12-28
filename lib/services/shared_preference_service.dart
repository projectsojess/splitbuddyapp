import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/login_response.dart';

class SharedPreferenceService {
  static SharedPreferences? _prefs;
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  static Future<bool> setLoginData(LoginResponse user) async {
    await _ensureInitialized();
    _prefs!.setInt("userId", user.userId);
    _prefs!.setString(RequestHeaders.JWT_HEADER, user.token);
    return _prefs!.setBool("isLoggedIn", true);
  }

  static Future<bool> setString(String key, String value) async {
    await _ensureInitialized();
    return _prefs!.setString(key, value);
  }

  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    await initialize();
    return _prefs!.getInt(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) async {
    await _ensureInitialized();
    return _prefs!.setInt(key, value);
  }

  static Future<bool> SetBool(String key, bool value) async {
    await _ensureInitialized();
    return _prefs!.setBool(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    await initialize();
    return _prefs!.getBool(key) ?? defaultValue;
  }

  static Future<String> getString(String key,
      {String defaultValue = ''}) async {
    await initialize();
    return _prefs!.getString(key) ?? defaultValue;
  }

  static Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  // ... other methods ...
}
