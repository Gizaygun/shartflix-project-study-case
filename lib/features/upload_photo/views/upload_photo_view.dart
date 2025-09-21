import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/providers/auth_provider.dart';

class UploadPhotoView extends StatefulWidget {
  const UploadPhotoView({super.key});

  @override
  State<UploadPhotoView> createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends State<UploadPhotoView> {
  File? _selectedPhoto;

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);
      setState(() => _selectedPhoto = file);


      if (mounted) {
        await context.read<AuthProvider>().updateProfilePhoto(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Fotoğraf Yükle", style: AppTextStyles.heading3),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _pickPhoto,
          child: _selectedPhoto != null || (user?.photoUrl?.isNotEmpty ?? false)
              ? Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: _selectedPhoto != null
                    ? Image.file(
                  _selectedPhoto!,
                  width: 176,
                  height: 176,
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  user!.photoUrl!,
                  width: 176,
                  height: 176,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedPhoto = null),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          )
              : Container(
            width: 176,
            height: 176,
            decoration: BoxDecoration(
              color: AppColors.white5,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: AppColors.white20,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: const Center(
              child: Icon(Icons.add, color: Colors.white60, size: 48),
            ),
          ),
        ),
      ),
    );
  }
}
