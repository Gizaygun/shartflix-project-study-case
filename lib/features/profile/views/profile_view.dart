
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/favorites_provider.dart';
import '../../home/widgets/movie_card.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final favorites = context.watch<FavoritesProvider>().favorites; // ✅ getter eklenmeli
    final user = auth.user;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Profil", style: AppTextStyles.heading2), // ✅ heading3 yerine
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              auth.logout();
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Profil Fotoğrafı
            if (user?.photoUrl != null && user!.photoUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.network(
                  user.photoUrl!,
                  width: 176,
                  height: 176,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: 176,
                height: 176,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05), // ✅ AppColors.white5 yerine
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white.withOpacity(0.2)), // ✅ white20
                ),
                child: Icon(Icons.person,
                    size: 64, color: Colors.white.withOpacity(0.4)), // ✅ white40
              ),

            const SizedBox(height: 16),

            // ✅ Kullanıcı Adı
            Text(
              user?.name ?? "Kullanıcı",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 32),

            // ✅ Favori Filmler
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Favori Filmlerim", style: AppTextStyles.heading2),
            ),
            const SizedBox(height: 16),

            favorites.isEmpty
                ? Text(
              "Henüz favori film yok",
              style: AppTextStyles.bodyMedium
                  .copyWith(color: Colors.white.withOpacity(0.6)), // ✅ white60
            )
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 169 / 251,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final movie = favorites[index];
                return MovieCard(movie: movie);
              },
            ),
          ],
        ),
      ),
    );
  }
}
