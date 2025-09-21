import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _k = 'auth_token';

  static Future<void> save(String token) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_k, token);
  }

  static Future<String?> read() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_k);
  }

  static Future<void> clear() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(_k);
  }
}
