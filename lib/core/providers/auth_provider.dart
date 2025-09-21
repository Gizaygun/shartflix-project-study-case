import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../network/api_client.dart';
import '../network/token_storage.dart';

import '../../features/auth/services/auth_service.dart';
import '../../features/upload_photo/services/upload_service.dart';

class AuthProvider extends ChangeNotifier {
  final _authService = AuthService();
  final _uploadService = UploadService();

  AppUser? _user;
  bool _isLoading = false;
  String? _photoUrlOverride;

  AppUser? get user => _user;
  bool get isLoading => _isLoading;
  String? get photoUrl => _photoUrlOverride ?? _user?.photoUrl;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await _authService.login(email, password);
      final data = (res['data'] ?? {}) as Map<String, dynamic>;

      final token = (data['token'] ?? '').toString();
      if (token.isEmpty) throw Exception('Token alınamadı');

      ApiClient().setToken(token);
      await TokenStorage.save(token);

      _user = AppUser.fromLoginData(data);
      _photoUrlOverride = null;
      return true;
    } catch (e) {
      if (kDebugMode) print('login error: $e');
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
      final res = await _authService.register(name, email, password);
      final data = (res['data'] ?? {}) as Map<String, dynamic>;

      final token = (data['token'] ?? '').toString();
      if (token.isNotEmpty) {
        ApiClient().setToken(token);
        await TokenStorage.save(token);
      }

      _user = data.isNotEmpty ? AppUser.fromLoginData(data) : null;
      _photoUrlOverride = null;
      return true;
    } catch (e) {
      if (kDebugMode) print('register error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfilePhoto(File file) async {
    try {
      // UploadService tarafının imzası: Future<String> uploadPhoto(File file)
      // (Eğer sende StreamedResponse dönen eski versiyon varsa haber ver, onu da uyumlarım.)
      final String url = await _uploadService.uploadPhoto(file);
      if (url.isEmpty) return false;

      // 1) UI'ı anında güncelle
      _photoUrlOverride = url;

      // 2) Kullanıcı modelini güncelle
      if (_user != null) {
        try {
          _user = _user!.copyWith(photoUrl: url);
        } catch (_) {
          _user = AppUser(
            id: _user!.id,
            name: _user!.name,
            email: _user!.email,
            photoUrl: url,
            token: _user!.token,
          );
        }
      }

      notifyListeners();

      await refreshProfile();
      return true;
    } catch (e) {
      if (kDebugMode) print('updateProfilePhoto error: $e');
      return false;
    }
  }

  Future<bool> refreshProfile() async {
    try {
      final res = await ApiClient().get('/user/profile');
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      final data = (json['data'] ?? {}) as Map<String, dynamic>;
      if (data.isEmpty) return false;

      _user = AppUser.fromLoginData(data);
      _photoUrlOverride = null; // sunucudaki kesin değer
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) print('refreshProfile error: $e');
      return false;
    }
  }


  Future<void> ensureProfileLoaded() async {
    if (_user == null) {
      await refreshProfile();
    }
  }


  Future<void> logout() async {
    ApiClient().setToken(null);
    await TokenStorage.clear();
    _user = null;
    _photoUrlOverride = null;
    notifyListeners();
  }
}
