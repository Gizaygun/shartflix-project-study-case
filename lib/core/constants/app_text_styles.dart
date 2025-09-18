import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // 🔤 Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 59 / 48,
    fontFamily: "InstrumentSans",
    color: AppColors.white100,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 40 / 32,
    fontFamily: "InstrumentSans",
    color: AppColors.white100,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
    fontFamily: "InstrumentSans",
    color: AppColors.white100,
  );

  // 🔤 Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    fontFamily: "InstrumentSans",
    color: AppColors.white100,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    fontFamily: "InstrumentSans",
    color: AppColors.white100,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    fontFamily: "InstrumentSans",
    color: AppColors.white100,
  );

  // ✅ Eksik olan "body" eklendi
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: "InstrumentSans",
    color: AppColors.white100,
  );

  // 🔤 Buttons / Labels
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: "InstrumentSans",
    color: AppColors.white100,
  );

  // 🔤 Inputs
  static const TextStyle inputText = bodyLarge;
  static const TextStyle inputHint = bodyMedium;
}
