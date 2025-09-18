import '../models/movie.dart';

class FavoritesService {
  final List<Movie> _favorites = [];

  Future<List<Movie>> getFavorites() async {
    return Future.value(List.unmodifiable(_favorites));
  }

  Future<bool> addFavorite(int id) async { // ✅ String değil, int
    if (!_favorites.any((m) => m.id == id)) {
      _favorites.add(Movie(id: id, title: "Dummy", poster: ""));
      return true;
    }
    return false;
  }

  Future<bool> removeFavorite(int id) async {
    _favorites.removeWhere((m) => m.id == id);
    return true;
  }
}
