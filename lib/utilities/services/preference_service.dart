import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static Future set(String key, String value) async {
    (await SharedPreferences.getInstance()).setString(key, value);
  }

  static Future<String> get(String key, String defaultValue) async {
    final storage = await SharedPreferences.getInstance();

    String? value;
    try {
      value = storage.getString(key);
      // ignore: empty_catches
    } catch (e) {}

    return value ?? defaultValue;
  }
}

class PreferenceKeys {
  static String trackActivation = "trackActivation";
}
