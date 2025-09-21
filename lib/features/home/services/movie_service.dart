import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/network/api_client.dart';
import 'package:shartflix/core/models/movie.dart';


class MoviePage {
  final List<Movie> movies;
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  MoviePage({
    required this.movies,
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });
}

class MovieService {
  static final MovieService _i = MovieService._();
  MovieService._();
  factory MovieService() => _i;

  final ApiClient _api = ApiClient();


  final List<Movie> _cache = [];


  List<Movie> getCachedMovies() => List.unmodifiable(_cache);


  Future<List<Movie>> getMoviesLegacy({int page = 1}) async {
    final pageData = await getMovies(page: page);
    return pageData.movies;
  }


  Future<MoviePage> getMovies({int page = 1}) async {
    final http.Response res =
    await _api.get('/movie/list', query: {'page': '$page'});

    final Map<String, dynamic> root = jsonDecode(res.body);

    final Map<String, dynamic> data =
    (root['data'] as Map<String, dynamic>? ?? {});

    final List list = (data['movies'] as List? ?? []);

    final movies = list.map<Movie>((e) {
      // Swagger: Büyük harfli anahtarlar geliyor. Ufak normalize yapalım.
      final m = Map<String, dynamic>.from(e as Map);

      // ID normalizasyonu
      m['id'] = m['id'] ?? m['_id'];

      // Title -> title
      m['title'] = m['title'] ?? m['Title'];

      // Poster -> posterUrl (http -> https fix)
      final posterRaw = (m['Poster'] ?? m['posterUrl'])?.toString();
      m['posterUrl'] = posterRaw == null ? null : _fixUrl(posterRaw);

      // Plot -> description
      m['description'] = m['description'] ?? m['Plot'];

      // Images dizisini de https'e çekelim (varsa)
      final images = (m['Images'] as List?)?.map((x) => _fixUrl('$x')).toList();
      if (images != null) m['images'] = images;

      // isFavorite alanı direkt geliyor
      // (yoksa false kabul edelim)
      m['isFavorite'] = m['isFavorite'] ?? false;

      // Modeliniz Movie.fromJson(Map) bekliyor.
      return Movie.fromJson(m);
    }).toList();

    // Pagination bilgisi
    final pg = (data['pagination'] as Map<String, dynamic>? ?? {});
    final totalCount = pg['totalCount'] is int ? pg['totalCount'] as int : 0;
    final perPage = pg['perPage'] is int ? pg['perPage'] as int : movies.length;
    final maxPage = pg['maxPage'] is int ? pg['maxPage'] as int : 1;
    final currentPage = pg['currentPage'] is int ? pg['currentPage'] as int : page;

    // Cache güncelle
    if (currentPage <= 1) {
      _cache
        ..clear()
        ..addAll(movies);
    } else {
      _cache.addAll(movies);
    }

    return MoviePage(
      movies: movies,
      totalCount: totalCount,
      perPage: perPage,
      maxPage: maxPage,
      currentPage: currentPage,
    );
  }


  Future<bool> toggleFavorite(String movieId) async {
    final http.Response res =
    await _api.post('/movie/favorite/$movieId'); // body yok


    final root = jsonDecode(res.body) as Map<String, dynamic>;
    final resp = root['response'] as Map<String, dynamic>?;

    final ok = (res.statusCode == 200) ||
        (resp != null && (resp['code'] == 200 || resp['code'] == '200'));

    if (ok) {

      final idx = _cache.indexWhere((m) => m.id == movieId);
      if (idx != -1) {
        final movie = _cache[idx];
        _cache[idx] = movie.copyWith(isFavorite: !movie.isFavorite);

      }
    }

    return ok;
  }


  String _fixUrl(String url) {
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }
    return url;
  }
}
