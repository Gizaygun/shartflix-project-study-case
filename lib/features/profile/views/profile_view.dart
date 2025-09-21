import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/favorites_provider.dart';
import '../../../l10n/S.dart';
import '../../home/widgets/movie_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isGrid = true;
  bool _uploading = false;

  Future<void> _pickAndUpload() async {
    try {
      final picker = ImagePicker();
      final x = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1280,
        maxHeight: 1280,
      );
      if (x == null) return;

      setState(() => _uploading = true);

      final ok = await context.read<AuthProvider>().updateProfilePhoto(File(x.path));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ok ? S.of(context)!.photoUpdated : S.of(context)!.photoUpdateFailed),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${S.of(context)!.error}: $e")),
      );
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final favorites = context.watch<FavoritesProvider>().favorites;

    final String? rawUrl = auth.photoUrl;
    final String photoUrl = (rawUrl == null || rawUrl.isEmpty)
        ? ''
        : '$rawUrl?v=${DateTime.now().millisecondsSinceEpoch ~/ 60000}';

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ✅ Login / Register / Home ile aynı heading2 stili + localization
        title: Text(S.of(context)!.profileTitle, style: AppTextStyles.heading2),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 📷 Profil fotoğrafı
            Stack(
              alignment: Alignment.center,
              children: [
                if (photoUrl.isEmpty)
                  _placeholderAvatar()
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      photoUrl,
                      key: ValueKey(photoUrl),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholderAvatar(),
                    ),
                  ),
                if (_uploading)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            TextButton.icon(
              onPressed: _uploading ? null : _pickAndUpload,
              icon: const Icon(Icons.photo_camera, color: Colors.white),
              label: Text(
                S.of(context)!.changePhoto,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // 👤 İsim
            Text(
              auth.user?.name ?? S.of(context)!.defaultUser,
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 24),

            // Başlık + görünüm toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context)!.favoritesTitle, style: AppTextStyles.heading2),
                IconButton(
                  icon: Icon(
                    _isGrid ? Icons.view_list : Icons.grid_view,
                    color: Colors.white,
                  ),
                  onPressed: () => setState(() => _isGrid = !_isGrid),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Favoriler
            Expanded(
              child: favorites.isEmpty
                  ? Center(
                child: Text(
                  S.of(context)!.noFavorites,
                  style: const TextStyle(color: Colors.white70),
                ),
              )
                  : AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SizeTransition(
                    sizeFactor: anim,
                    axisAlignment: -1,
                    child: child,
                  ),
                ),
                child: _isGrid
                    ? GridView.builder(
                  key: const ValueKey('grid'),
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 169 / 251,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, i) => MovieCard(movie: favorites[i]),
                )
                    : ListView.builder(
                  key: const ValueKey('list'),
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 4),
                  itemCount: favorites.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                      height: 251,
                      child: MovieCard(movie: favorites[i]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderAvatar() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Icon(Icons.person, size: 60, color: Colors.white54),
    );
  }
}
