import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio dio;
  String? token;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://caseapi.servicelabs.tech',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));
  }

  void setToken(String newToken) {
    token = newToken;
    dio.options.headers['Authorization'] = 'Bearer $newToken';
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }
}
