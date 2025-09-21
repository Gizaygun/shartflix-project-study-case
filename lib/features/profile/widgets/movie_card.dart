import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/favorites_provider.dart';
import '../models/movie.dart';
import '../views/movie_detail_view.dart';
import '../services/movie_service.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(movie.id);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => MovieDetailView(movie: movie)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Poster
            Positioned.fill(
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Center(child: Icon(Icons.broken_image)),
              ),
            ),

            // Favori
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () async {
                  final favs = context.read<FavoritesProvider>();
                  final wasFav = favs.isFavorite(movie.id);

                  // ✅ Movie objesini de ilet: profil grid'i bu sayede dolacak
                  favs.toggleFavorite(movie.id, movie: movie);

                  // Optimistic UI, API çağrısı
                  try {
                    await MovieService().toggleFavorite(movie.id);
                  } catch (_) {
                    // Hata -> geri al
                    if (wasFav != favs.isFavorite(movie.id)) {
                      favs.toggleFavorite(movie.id, movie: movie);
                    }
                  }
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFavorite ? const Color(0xFFE50914) : Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
