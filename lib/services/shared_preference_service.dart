import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferences? _prefs;
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  static Future<bool> setString(String key, String value) async {
    await _ensureInitialized();
    return _prefs!.setString(key, value);
  }

  static String getString(String key, {String defaultValue = ''}) {
    _ensureInitializedSync();
    return _prefs!.getString(key) ?? defaultValue;
  }

  static void _ensureInitializedSync() {
    if (!_initialized) {
      throw Exception('SharedPreferences not initialized');
    }
  }

  static Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  // ... other methods ...
}
