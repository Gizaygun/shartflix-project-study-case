import 'dart:convert';
import 'package:http/http.dart' as http;

// Paket ismi pubspec'deki "name" ile aynıdır:
import 'package:jr_case_boilerplate/features/home/models/movie.dart';

class MovieService {
  static List<Movie> _cache = [];

  /// API'den filmleri getir ve cache'e yaz
  Future<List<Movie>> getMovies() async {
    // Kendi endpoint’ini buraya yaz:
    final url = Uri.parse("https://senin-api-endpointin.com/movies");

    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("Filmler alınamadı: ${res.statusCode}");
    }

    final List<dynamic> data = jsonDecode(res.body);
    _cache = data.map((e) => Movie.fromJson(e)).toList();
    return _cache;
  }

  /// Cache edilmiş filmleri döndür
  List<Movie> getCachedMovies() => _cache;
}
