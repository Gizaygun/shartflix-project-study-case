import 'package:flutter/material.dart';
import '../constants/app_radius.dart';

class LikedMovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const LikedMovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 169,
      height: 196,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.likedCard),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AppRadius.likedCard),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
