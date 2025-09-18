import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';

class CustomPhotoUpload extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onUpload;
  final VoidCallback onRemove;

  const CustomPhotoUpload({
    super.key,
    this.imageUrl,
    required this.onUpload,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: AppColors.photoBg,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          child: imageUrl == null
              ? const Icon(Icons.person, size: 48, color: AppColors.white)
              : null,
        ),
        Positioned(
          bottom: -6,
          right: -6,
          child: IconButton.filledTonal(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: const CircleBorder(),
            ),
            onPressed: onUpload,
            icon: const Icon(Icons.edit, size: 20),
          ),
        ),
        if (imageUrl != null)
          Positioned(
            top: -6,
            right: -6,
            child: IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close, color: AppColors.white, size: 20),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
                shape: const CircleBorder(),
              ),
            ),
          ),
      ],
    );
  }
}
