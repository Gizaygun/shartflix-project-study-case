import 'package:flutter/material.dart';

Route fade(Widget page) => PageRouteBuilder(
  pageBuilder: (_, __, ___) => page,
  transitionsBuilder: (_, anim, __, child) =>
      FadeTransition(opacity: anim, child: child),
);
