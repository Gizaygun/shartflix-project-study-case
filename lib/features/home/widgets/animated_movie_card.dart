import 'package:flutter/material.dart';
import 'package:shartflix/core/models/movie.dart';
import 'package:shartflix/features/home/widgets/movie_card.dart';

class AnimatedMovieCard extends StatefulWidget {
  final Movie movie;
  final int index;
  const AnimatedMovieCard({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  State<AnimatedMovieCard> createState() => _AnimatedMovieCardState();
}

class _AnimatedMovieCardState extends State<AnimatedMovieCard> {
  bool _shown = false;

  @override
  void initState() {
    super.initState();

    final delay = Duration(milliseconds: 60 * (widget.index % 8));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(delay);
      if (mounted) setState(() => _shown = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    const d = Duration(milliseconds: 420);
    return AnimatedOpacity(
      duration: d,
      curve: Curves.easeOutCubic,
      opacity: _shown ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: d,
        curve: Curves.easeOutCubic,
        offset: _shown ? Offset.zero : const Offset(0, 0.08),
        child: AnimatedScale(
          duration: d,
          curve: Curves.easeOutBack,
          scale: _shown ? 1.0 : 0.92,
          child: MovieCard(movie: widget.movie),
        ),
      ),
    );
  }
}
