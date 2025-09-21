import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // <-- BURASI EKLENDİ
import '../../../core/network/token_storage.dart';

class UploadService {
  static const String _uploadUrl =
      'https://caseapi.servicelabs.tech/user/upload_photo';

  Future<String> uploadPhoto(File file) async {
    final token = await TokenStorage.read();
    if (token == null || token.isEmpty) {
      throw Exception('Token bulunamadı.');
    }

    final uri = Uri.parse(_uploadUrl);

    final request = http.MultipartRequest('POST', uri)
      ..headers['accept'] = 'application/json'
      ..headers['Authorization'] = token
      ..files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          filename: file.uri.pathSegments.isNotEmpty
              ? file.uri.pathSegments.last
              : 'avatar.jpg',
          contentType: MediaType('image', _inferExt(file.path)), // <-- DOĞRU
        ),
      );

    final streamed = await request.send();
    final resp = await http.Response.fromStream(streamed);

    if (resp.statusCode == 200) {
      final body = resp.body;
      final idx = body.indexOf('"photoUrl"');
      if (idx != -1) {
        final start = body.indexOf('"', idx + 11) + 1;
        final end = body.indexOf('"', start);
        if (start > 0 && end > start) {
          return body.substring(start, end);
        }
      }
      return "";
    } else if (resp.statusCode == 400) {
      return "";
    } else if (resp.statusCode == 401) {
      throw Exception('Unauthorized (401) – token geçersiz/expired olabilir.');
    } else {
      throw Exception('Upload hata: HTTP ${resp.statusCode}');
    }
  }

  String _inferExt(String path) {
    final p = path.toLowerCase();
    if (p.endsWith('.png')) return 'png';
    if (p.endsWith('.webp')) return 'webp';
    if (p.endsWith('.heic')) return 'heic';
    if (p.endsWith('.jpeg')) return 'jpeg';
    if (p.endsWith('.jpg')) return 'jpeg';
    return 'jpeg';
  }
}
