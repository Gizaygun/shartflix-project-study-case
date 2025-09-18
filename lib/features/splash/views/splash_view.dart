import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/features/auth/views/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    // 2 saniye sonra LoginView'a yönlendirme
    Timer(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Text(
          "Shartflix",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
