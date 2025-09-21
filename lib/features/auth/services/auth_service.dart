import 'dart:convert';
import '../../../core/network/api_client.dart';

class AuthService {
  final _api = ApiClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _api.post('/user/login', body: {
      'email': email,
      'password': password,
    });
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final res = await _api.post('/user/register', body: {
      'name': name,
      'email': email,
      'password': password,
    });
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
