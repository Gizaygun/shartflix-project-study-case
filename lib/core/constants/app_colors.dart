import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primary = Color(0xFFE50914);
  static const Color secondary = Color(0xFFB81D24);
  static const Color error = Color(0xFFB00020);

  // Base
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Opacity whites (projede referans verilenler)
  static const Color white5  = Color(0x0DFFFFFF); // ~%5
  static const Color white20 = Color(0x33FFFFFF); // ~%20
  static const Color white40 = Color(0x66FFFFFF); // ~%40
  static const Color white60 = Color(0x99FFFFFF); // ~%60
  static const Color white80 = Color(0xCCFFFFFF); // ~%80
  static const Color white100 = Color(0xFFFFFFFF);

  // Surfaces
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Inputs / Checkbox
  static const Color inputBackground = Color(0xFF2A2A2A);
  static const Color inputBorder = Color(0xFF3A3A3A);
  static const Color checkboxFill = Color(0xFF2E2E2E);
  static const Color checkboxBorder = Color(0xFF4D4D4D);

  // Ekstra kullanılanlar
  static const Color darkGray = Color(0xFF2C2C2C);

  // Bazı UI’larda kullanılan coin gradient (Limited Offer)
  static const Gradient coinGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
