import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/providers/favorites_provider.dart';
import 'package:jr_case_boilerplate/features/home/models/movie.dart';
import 'package:jr_case_boilerplate/features/home/views/movie_detail_view.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(movie.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieDetailView(movie: movie)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: AppColors.surfaceDark, // dark theme’de de şık dursun
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Poster + Hero
            Hero(
              tag: 'movie_${movie.id}',
              child: Image.network(
                movie.poster,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.darkGray,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, color: Colors.white70),
                ),
              ),
            ),

            // Üst sağ: Favori butonu
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.35),
                ),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.primary : AppColors.white,
                ),
                onPressed: () {
                  context.read<FavoritesProvider>().toggleFavorite(movie.id);
                },
              ),
            ),

            // Alt: Başlık şeridi
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
