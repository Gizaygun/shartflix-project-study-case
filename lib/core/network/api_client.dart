import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://caseapi.servicelabs.tech';
  static final ApiClient _i = ApiClient._();
  ApiClient._();
  factory ApiClient() => _i;

  String? _token;
  void setToken(String? t) => _token = t;
  String? get token => _token; //

  Future<http.Response> get(String path, {Map<String, String>? query}) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final headers = <String, String>{
      'accept': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
    final res = await http.get(uri, headers: headers);
    _throwIfError(res);
    return res;
  }

  Future<http.Response> post(String path, {Object? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
    final res = await http.post(
      uri,
      headers: headers,
      body: body == null ? null : jsonEncode(body),
    );
    _throwIfError(res);
    return res;
  }

  void _throwIfError(http.Response res) {
    if (res.statusCode >= 400) {
      throw ApiError(res.statusCode, res.body);
    }
  }
}

class ApiError implements Exception {
  final int code;
  final String body;
  ApiError(this.code, this.body);
  @override
  String toString() => 'ApiError($code): $body';
}
