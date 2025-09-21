import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/models/app_user.dart';
import '../../../core/network/api_client.dart';

class ProfileService {
  final _api = ApiClient();

  Future<AppUser> getProfile() async {
    final http.Response res = await _api.get('/user/profile');
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final data = (body['data'] ?? {}) as Map<String, dynamic>;
    return AppUser.fromLoginData(data);
  }
}
