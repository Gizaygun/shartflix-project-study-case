import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed; // nullable (for disabled state)
  final bool fullWidth;
  final IconData? leftIcon;
  final IconData? rightIcon;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.fullWidth = true,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 56, // ✅ Figma → 56px
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // ✅ Figma → 8px
          ),
          elevation: 0, // Figma
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leftIcon != null) ...[
              Icon(leftIcon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: AppTextStyles.button,
              textAlign: TextAlign.center,
            ),
            if (rightIcon != null) ...[
              const SizedBox(width: 8),
              Icon(rightIcon, color: Colors.white, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
