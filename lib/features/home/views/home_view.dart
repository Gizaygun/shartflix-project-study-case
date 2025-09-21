import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/providers/favorites_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../l10n/S.dart';
import '../../../core/widgets/bottom_sheet/coin_offer_sheet.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favProv = context.watch<FavoritesProvider>();
    final localeProv = context.watch<LocaleProvider>();

    // Mock movies (API bağlanana kadar)
    final movies = [
      Movie(
        id: "1",
        title: "Avatar",
        posterUrl:
        "https://image.tmdb.org/t/p/w500/6EiRUJpuoeQPghrs3YNktfnqOVh.jpg",
        producer: "James Cameron",
      ),
      Movie(
        id: "2",
        title: "I Am Legend",
        posterUrl:
        "https://image.tmdb.org/t/p/w500/iPDkaSdKk2jRLTM65UOEoKtsIZ8.jpg",
        producer: "Warner Bros",
      ),
      Movie(
        id: "3",
        title: "300",
        posterUrl:
        "https://image.tmdb.org/t/p/w500/hiKmpZMGZsrkA3cdce8a7Dpos1j.jpg",
        producer: "Legendary Pictures",
      ),
      Movie(
        id: "4",
        title: "The Avengers",
        posterUrl:
        "https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg",
        producer: "Marvel Studios",
      ),
    ];

    favProv.seedMovies(movies);

    return Scaffold(
      backgroundColor: AppColors.black,

      // ✅ AppBar (pixel perfect language button)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(S.of(context)!.homeTitle, style: AppTextStyles.heading2),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                final newLocale =
                (localeProv.locale?.languageCode ?? 'en') == 'en'
                    ? const Locale('tr')
                    : const Locale('en');
                localeProv.setLocale(newLocale);
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.redAccent.withOpacity(0.5),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.language,
                  color: Colors.redAccent,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),

      // ✅ FAB (gradient coin offer)
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 8),
        child: GestureDetector(
          onTap: () async {
            final choice = await showCoinOfferSheet(context);
            if (choice != null && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Seçilen paket: $choice")),
              );
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF5949E6), Color(0xFFE50914)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_offer, color: Colors.white, size: 22),
                const SizedBox(width: 8),
                Text(
                  S.of(context)!.limitedOffer,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 169 / 251, // 🎯 Figma oranı
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final animation = Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: Interval(
              (index / movies.length),
              1.0,
              curve: Curves.easeOut,
            ),
          ));

          return FadeTransition(
            opacity: _controller,
            child: SlideTransition(
              position: animation,
              child: MovieCard(movie: movies[index]),
            ),
          );
        },
      ),
    );
  }
}
