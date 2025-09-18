import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/constants/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56, // ✅ Figma → 56px
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.white100), // ✅ text style
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.white40), // ✅ hint style
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppColors.white40)
              : null,
          filled: true,
          fillColor: AppColors.white5, // ✅ bg
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // ✅ padding
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppColors.white20, width: 1), // ✅ border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
