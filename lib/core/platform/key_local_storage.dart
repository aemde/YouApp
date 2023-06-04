import 'package:shared_preferences/shared_preferences.dart';

class KeyLocalStorage {
  Future<String> readAuthStorage(String key) async {
    final storage = await SharedPreferences.getInstance();
    final userId = storage.getString(key);
    if (userId != null) {
      return userId;
    } else {
      return '';
    }
  }

  Future writeAuthStorage(String key, String value) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString(key, value);
  }

  Future deleteAuthStorage(String key) async {
    final storage = await SharedPreferences.getInstance();
    storage.remove(key);
  }
}
