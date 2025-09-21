import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/providers/favorites_provider.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final favProv = context.watch<FavoritesProvider>();
    final isFav = favProv.isFavorite(movie.id);

    return Container(
      width: 169,
      height: 251,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // 🎬 Poster
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              movie.posterUrl,
              width: 169,
              height: 196,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 169,
                height: 196,
                color: Colors.grey.shade800,
                child: const Icon(Icons.broken_image, color: Colors.white54),
              ),
            ),
          ),


          Positioned(
            top: 12,
            left: 20,
            child: GestureDetector(
              onTap: () => favProv.toggleFavorite(movie.id, movie: movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: 52,
                    height: 72,
                    padding: const EdgeInsets.fromLTRB(14, 24, 14, 24),
                    decoration: BoxDecoration(
                      color: const Color(0x33000000), // #00000033
                      border: Border.all(
                        color: const Color(0x99FFFFFF), // #FFFFFF99
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? AppColors.primary : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            bottom: 0,
            child: Container(
              width: 169,
              height: 39,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: Colors.black.withOpacity(0.5), // #FFFFFF80 şeffaflık efekti
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "InstrumentSans",
                      fontWeight: FontWeight.w600, // SemiBold
                      fontSize: 14,
                      height: 1.0, // line-height 100%
                      letterSpacing: 0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.producer,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: "InstrumentSans",
                      fontWeight: FontWeight.w400, // Regular
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
