import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/auth_response.dart';

class AuthService {
  final ApiClient _api = ApiClient();

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final res = await _api.post(
      "/user/login",
      data: {"email": email, "password": password},
    );
    if (res.statusCode == 200) {
      return AuthResponse.fromJson(res.data);
    }
    throw DioException(
      requestOptions: res.requestOptions,
      response: res,
      type: DioExceptionType.badResponse,
      message: "Login failed",
    );
  }

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _api.post(
      "/user/register",
      data: {"name": name, "email": email, "password": password},
    );
    if (res.statusCode == 200) {
      return AuthResponse.fromJson(res.data);
    }
    throw DioException(
      requestOptions: res.requestOptions,
      response: res,
      type: DioExceptionType.badResponse,
      message: "Register failed",
    );
  }
}
