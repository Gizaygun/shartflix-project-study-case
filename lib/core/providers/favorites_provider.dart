import 'package:flutter/material.dart';

// Paket importları, relative karmaşayı önler:
import 'package:jr_case_boilerplate/features/home/models/movie.dart';
import 'package:jr_case_boilerplate/features/home/services/movie_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favoriteMovieIds = {};

  Set<int> get favoriteMovieIds => _favoriteMovieIds;

  bool isFavorite(int movieId) => _favoriteMovieIds.contains(movieId);

  void toggleFavorite(int movieId) {
    if (_favoriteMovieIds.contains(movieId)) {
      _favoriteMovieIds.remove(movieId);
    } else {
      _favoriteMovieIds.add(movieId);
    }
    notifyListeners();
  }

  /// Favori filmleri List<Movie> olarak döndür (MovieService cache üzerinden)
  List<Movie> get favorites {
    final all = MovieService().getCachedMovies();
    return all.where((m) => _favoriteMovieIds.contains(m.id)).toList();
  }
}
