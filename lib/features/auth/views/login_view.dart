import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/custom_checkbox.dart';
import '../../../core/widgets/social_login_row.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/providers/auth_provider.dart';
import '../../nav_bar/main_shell.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  Future<void> _login() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;
    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Giriş başarısız!")),
      );
    }
  }

  void _goToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // ✅ padding parametresi
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // ✅ doğru yazım
              children: [
                const SizedBox(height: 40),

                // 🔥 Lottie animasyon (Login → shywolflgn.json)
                SizedBox(
                  height: 180,
                  child: Lottie.asset("assets/lottie/shywolflgn.json"),
                ),
                const SizedBox(height: 20),

                Text(
                  "Giriş Yap",
                  style: AppTextStyles.heading1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

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
                const SizedBox(height: 16),

                // Remember Me
                CustomCheckbox(
                  value: rememberMe,
                  onChanged: (val) => setState(() => rememberMe = val),
                  label: "Beni hatırla",
                ),
                const SizedBox(height: 24),

                // Login Button
                CustomButton(
                  label: isLoading ? "Yükleniyor..." : "Giriş Yap",
                  onPressed: isLoading ? null : _login,
                ),

                const SizedBox(height: 20),

                // Go to Register
                TextButton(
                  onPressed: _goToRegister,
                  child: const Text(
                    "Hesabın yok mu? Kayıt Ol",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

                const SizedBox(height: 40),

                // Social Login
                SocialLoginRow(
                  onGoogleTap: () => debugPrint("Google login"),
                  onAppleTap: () => debugPrint("Apple login"),
                  onFacebookTap: () => debugPrint("Facebook login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
