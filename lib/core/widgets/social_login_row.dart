import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';

class SocialLoginRow extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final VoidCallback onFacebookTap;

  const SocialLoginRow({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
    required this.onFacebookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "veya",
          style: AppTextStyles.body.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(
              icon: Icons.g_mobiledata, // Google için (istersen asset ekleriz)
              color: Colors.red,
              onTap: onGoogleTap,
            ),
            const SizedBox(width: 20),
            _socialButton(
              icon: Icons.apple,
              color: Colors.white,
              onTap: onAppleTap,
            ),
            const SizedBox(width: 20),
            _socialButton(
              icon: Icons.facebook,
              color: Colors.blue,
              onTap: onFacebookTap,
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black.withOpacity(0.1),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
