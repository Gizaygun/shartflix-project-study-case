import 'dart:io';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class UploadService {
  final ApiClient _api = ApiClient();

  Future<String?> uploadProfilePhoto(File file) async {
    try {
      final form = FormData.fromMap({
        "photo": await MultipartFile.fromFile(file.path, filename: "profile.jpg"),
      });
      final res = await _api.post("/user/upload-photo", data: form);
      if (res.statusCode == 200 && res.data["url"] != null) {
        return res.data["url"] as String;
      }
      return null;
    } on DioException catch (e) {
      // Log tutmak istersen:
      // debugPrint("🔴 Upload error: ${e.response?.data ?? e.message}");
      return null;
    }
  }
}
