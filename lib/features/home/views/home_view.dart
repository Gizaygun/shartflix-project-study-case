import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/limited_offer_bottom_sheet.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import '../../../core/providers/favorites_provider.dart';
import '../widgets/animated_movie_card.dart'; // ✅ animasyonlu kart

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = MovieService().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Shartflix",
          style: AppTextStyles.heading1.copyWith(fontSize: 24),
        ),
        actions: [
          IconButton(
            tooltip: 'Sınırlı Teklif',
            icon: const Icon(Icons.local_offer_outlined, color: Colors.white),
            onPressed: () async {
              final selected = await showLimitedOfferSheet(context);
              if (!mounted) return;

              if (selected != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seçilen plan: $selected')),
                );
              }
            },
          ),
        ],
      ),

      // ✅ Animasyonlu film listesi
      body: FutureBuilder<List<Movie>>(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Film bulunamadı",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final movies = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 169 / 251, // ✅ Figma oranı
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return AnimatedMovieCard(
                movie: movies[index],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
