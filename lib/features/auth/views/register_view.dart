import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/providers/auth_provider.dart';
import 'login_view.dart';
import '../../upload_photo/views/upload_photo_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.register(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;
    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const UploadPhotoView()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kayıt başarısız!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // 🔥 Lottie animasyon (Register → pinkregistry.json)
                SizedBox(
                  height: 180,
                  child: Lottie.asset("assets/lottie/pinkregistry.json"),
                ),
                const SizedBox(height: 20),

                Text(
                  "Kayıt Ol",
                  style: AppTextStyles.heading1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Name
                CustomTextField(
                  hintText: "Ad Soyad",
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  hintText: "E-posta",
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  hintText: "Şifre",
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 24),

                // Register Button
                CustomButton(
                  label: isLoading ? "Yükleniyor..." : "Kayıt Ol",
                  onPressed: isLoading ? null : _register,
                ),

                const SizedBox(height: 20),

                // Go to Login
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginView()),
                    );
                  },
                  child: const Text(
                    "Hesabın var mı? Giriş Yap",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
