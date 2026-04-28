import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  AppStorage(this.preferences);

  final SharedPreferences preferences;

  String? getString(String key) => preferences.getString(key);

  Future<bool> setString(String key, String value) => preferences.setString(key, value);

  Future<bool> remove(String key) => preferences.remove(key);

  Future<bool> clear() => preferences.clear();
}
