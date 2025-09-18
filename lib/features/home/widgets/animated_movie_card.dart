import 'package:jr_case_boilerplate/features/home/models/movie.dart';
import 'package:flutter/material.dart';
import 'movie_card.dart';

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

class _AnimatedMovieCardState extends State<AnimatedMovieCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _offset = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Kartları sırayla göstermek için gecikme ekledik
    Future.delayed(Duration(milliseconds: 100 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: MovieCard(movie: widget.movie),
      ),
    );
  }
}
