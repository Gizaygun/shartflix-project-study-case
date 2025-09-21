import 'package:flutter/material.dart';
import '../../features/home/models/movie.dart';

class FavoritesProvider extends ChangeNotifier {
  final Map<String, Movie> _movies = {};
  final Set<String> _ids = {};

  List<Movie> get favorites =>
      _ids.map((id) => _movies[id]).whereType<Movie>().toList(growable: false);

  bool isFavorite(String id) => _ids.contains(id);

  void toggleFavorite(String id, {Movie? movie}) {
    if (_ids.contains(id)) {
      _ids.remove(id);
    } else {
      _ids.add(id);
      if (movie != null) _movies[id] = movie;
    }
    notifyListeners();
  }

  void seedMovies(Iterable<Movie> movies) {
    for (final m in movies) {
      _movies[m.id] = m;
    }
  }

  void setFavoritesFromBackend(Iterable<String> ids,
      {Iterable<Movie>? known}) {
    _ids
      ..clear()
      ..addAll(ids);
    if (known != null) {
      seedMovies(known);
    }
    notifyListeners();
  }
}
