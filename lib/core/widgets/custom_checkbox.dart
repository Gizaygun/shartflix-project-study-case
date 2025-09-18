import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
              color: value ? AppColors.primary : Colors.transparent,
            ),
            child: value
                ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            )
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white80),
        ),
      ],
    );
  }
}
