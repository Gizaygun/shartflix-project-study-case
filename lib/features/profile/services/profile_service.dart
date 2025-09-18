import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class ProfileService {
  final ApiClient _api = ApiClient();

  /// Profil bilgilerini getir
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final response = await _api.get("/user/profile");
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      print("🔴 Profile error: ${e.response?.data ?? e.message}");
      return null;
    }
  }

  /// Fotoğraf yükleme
  Future<bool> uploadPhoto(File file) async {
    try {
      final formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(file.path),
      });

      final response = await _api.post("/user/upload_photo", data: formData);
      return response.statusCode == 200;
    } on DioException catch (e) {
      print("🔴 Upload photo error: ${e.response?.data ?? e.message}");
      return false;
    }
  }
}
