import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/movies_provider.dart';
import '../models/movie.dart';

class MovieTile extends StatelessWidget {
  final int index;
  const MovieTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MoviesProvider>();
    final Movie m = prov.items[index];

    return RepaintBoundary(
      child: Stack(
        children: [
          // Poster
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                m.posterUrl,
                fit: BoxFit.cover,
                loadingBuilder: (c, w, p) => Container(color: Colors.white10),
                errorBuilder: (c, e, s) => Container(
                  color: Colors.white12,
                  child: const Icon(Icons.broken_image, color: Colors.white30),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0, right: 0, bottom: 0, height: 110,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                  ),
                ),
              ),
            ),
          ),

          // Başlık
          Positioned(
            left: 10, right: 48, bottom: 10,
            child: Text(
              m.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14, height: 1.2,
              ),
            ),
          ),

          // Favori butonu (bounce)
          Positioned(top: 8, right: 8, child: _FavButton(
            isFav: m.isFavorite,
            onTap: () => context.read<MoviesProvider>().toggleFavoriteOptimistic(index),
          )),
        ],
      ),
    );
  }
}

class _FavButton extends StatefulWidget {
  final bool isFav;
  final VoidCallback onTap;
  const _FavButton({required this.isFav, required this.onTap});

  @override
  State<_FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<_FavButton> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 160), lowerBound: 0.9, upperBound: 1.1,
  );

  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _c.drive(Tween(begin: 1.0, end: 1.0)),
      child: GestureDetector(
        onTap: () async {
          await _c.forward(from: 0.9);
          await _c.reverse();
          widget.onTap();
        },
        child: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(12)),
          child: Icon(
            widget.isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: widget.isFav ? const Color(0xFFE50914) : Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
