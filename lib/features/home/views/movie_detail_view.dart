import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/features/home/models/movie.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;

  const MovieDetailView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(movie.title, style: AppTextStyles.heading2),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Hero animasyonu
            Hero(
              tag: "movie_${movie.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  movie.poster,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Dummy açıklama (API’den çekilecekse buraya eklenir)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Film detay bilgileri burada olacak.\n\n"
                    "İsterlere uygun olarak buraya özet, açıklama veya trailer bağlantısı koyabilirsin.",
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
