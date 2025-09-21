import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/models/user_model.dart';

class AuthService {
  final ApiClient _api = ApiClient();


  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _api.post(
      "/user/login",
      data: {"email": email, "password": password},
    );

    if (response.statusCode == 200 && response.data["token"] != null) {
      return {
        "token": response.data["token"],
        "user": UserModel.fromJson(response.data["user"]),
      };
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: "Login failed",
        type: DioExceptionType.badResponse,
      );
    }
  }


  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await _api.post(
      "/user/register",
      data: {"name": name, "email": email, "password": password},
    );

    if (response.statusCode == 200 && response.data["token"] != null) {
      return {
        "token": response.data["token"],
        "user": UserModel.fromJson(response.data["user"]),
      };
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: "Register failed",
        type: DioExceptionType.badResponse,
      );
    }
  }
}
