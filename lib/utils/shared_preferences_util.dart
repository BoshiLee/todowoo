import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

// SharedPreferences
class SharedPreferencesUtils {
  static SharedPreferencesUtils? _singleton;
  static SharedPreferences? _prefs;
  static final Lock _lock = Lock();

  static Future<SharedPreferencesUtils> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = SharedPreferencesUtils._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton!;
  }

  SharedPreferencesUtils._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    if (!isInitialized()) return null;
    return _prefs?.getString(key);
  }

  static Future putString(String key, String value) async {
    if (!isInitialized()) return null;
    return await _prefs!.setString(key, value);
  }

  static Future<bool> remove(String key) async {
    if (!isInitialized()) return false;
    return await _prefs!.remove(key);
  }

  static Future<bool> clear() async {
    if (!isInitialized()) return false;
    return _prefs!.clear();
  }

  static bool isInitialized() {
    return _prefs != null;
  }
}
