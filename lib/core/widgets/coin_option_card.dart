import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_text_styles.dart';

class CoinOptionCard extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CoinOptionCard({
    super.key,
    required this.label,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 116,
        height: 186,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: selected
              ? const RadialGradient(
            center: Alignment(-0.7, -0.7),
            radius: 1.2,
            colors: AppColors.coinGradient,
          )
              : null,
          color: selected ? null : AppColors.black,
          borderRadius: BorderRadius.circular(AppRadius.coinOption),
          border: Border.all(
            color: AppColors.coinBorder,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: AppColors.white.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(4, 4),
            )
          ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.coinLabel,
          ),
        ),
      ),
    );
  }
}
