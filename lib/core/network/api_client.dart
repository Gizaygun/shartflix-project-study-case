import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://caseapi.servicelabs.tech",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {"Content-Type": "application/json"},
      ),
    );

    // Basit log interceptor (isteğe bağlı)
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
  }

  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio _dio;
  String? _token;

  void setToken(String token) {
    _token = token;
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  void clearToken() {
    _token = null;
    _dio.options.headers.remove("Authorization");
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) {
    return _dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) {
    return _dio.delete(path, data: data);
  }
}
