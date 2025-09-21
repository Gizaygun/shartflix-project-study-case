import 'package:flutter/foundation.dart';
import '../../features/home/models/movie.dart';
import '../../features/home/services/movie_service.dart';

class MoviesProvider extends ChangeNotifier {
  final _svc = MovieService();
  final List<Movie> _items = [];
  bool _loading = false;
  int _page = 1;
  int _totalPages = 1;

  List<Movie> get items => List.unmodifiable(_items);
  bool get loading => _loading;
  bool get canLoadMore => _page <= _totalPages;

  Future<void> refresh() async {
    _page = 1;
    _totalPages = 1;
    _items.clear();
    notifyListeners();
    await loadNext();
  }

  Future<void> loadNext() async {
    if (_loading || !canLoadMore) return;
    _loading = true;
    notifyListeners();
    try {
      final p = await _svc.getMovies(page: _page);
      _totalPages = p.totalPages;
      _page = p.currentPage + 1;
      _items.addAll(p.movies);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteOptimistic(int index) async {
    final prev = _items[index];
    _items[index] = prev.copyWith(isFavorite: !prev.isFavorite);
    notifyListeners();

    try {
      await _svc.toggleFavorite(prev.id);
    } catch (_) {
      // API fail -> geri al
      _items[index] = prev;
      notifyListeners();
      rethrow;
    }
  }
}
