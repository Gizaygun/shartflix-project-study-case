import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../features/auth/services/auth_service.dart';
import '../../features/auth/models/auth_response.dart';
import '../../features/auth/models/user.dart';
import '../../features/upload_photo/services/upload_service.dart';
import '../network/api_client.dart'; // ✅ Token set etmek için

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final ApiClient _api = ApiClient(); // ✅

  String? _token;
  User? _user;
  bool _isLoading = false;

  String? get token => _token;
  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final AuthResponse result = await _authService.login(
        email: email,
        password: password,
      );
      _token = result.token;
      _user = result.user;

      if (_token != null) {
        _api.setToken(_token!); // ✅ Tüm API isteklerinde kullanılsın
      }

      return true;
    } on DioException catch (e) {
      debugPrint("🔴 Login error: ${e.response?.data ?? e.message}");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final AuthResponse result = await _authService.register(
        name: name,
        email: email,
        password: password,
      );
      _token = result.token;
      _user = result.user;

      if (_token != null) {
        _api.setToken(_token!); // ✅
      }

      return true;
    } on DioException catch (e) {
      debugPrint("🔴 Register error: ${e.response?.data ?? e.message}");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fotoğrafı upload edip dönen url'i kullanıcıya yaz
  Future<void> updateProfilePhoto(File file) async {
    final url = await UploadService().uploadProfilePhoto(file);
    if (url != null && _user != null) {
      _user = _user!.copyWith(photoUrl: url);
      notifyListeners();
    }
  }

  void logout() {
    _token = null;
    _user = null;
    _api.setToken(""); // ✅ Token’ı sıfırla
    notifyListeners();
  }
}
