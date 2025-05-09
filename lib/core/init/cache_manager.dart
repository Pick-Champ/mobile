import 'package:shared_preferences/shared_preferences.dart';

final class CacheManager {
  CacheManager._init();

  late SharedPreferences prefs;
  static final CacheManager _instance = CacheManager._init();

  static CacheManager get instance => _instance;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? getUserId() {
    return prefs.getString('userId');
  }

  void setUserId(String value) {
    prefs.setString('userId', value);
  }

  void clearCache() {
    prefs.clear();
  }
}
