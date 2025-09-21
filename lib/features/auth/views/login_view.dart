import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/custom_checkbox.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/providers/auth_provider.dart';
import '../../nav_bar/view/main_shell.dart';
import 'register_view.dart';
import '../../../l10n/S.dart';
import '../../../core/widgets/social_login_row.dart';

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
        MaterialPageRoute(builder: (_) => MainShell()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context)!.loginFailed)),
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
      appBar: AppBar(
        title: Text(S.of(context)!.loginTitle, style: AppTextStyles.heading2),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // 🔥 Lottie animasyon
                SizedBox(
                  height: 180,
                  child: Lottie.asset("assets/lottie/shywolflgn.json"),
                ),
                const SizedBox(height: 20),

                // Email
                CustomTextField(
                  hintText: S.of(context)!.email,
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  hintText: S.of(context)!.password,
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 16),

                // Remember Me
                CustomCheckbox(
                  value: rememberMe,
                  onChanged: (val) => setState(() => rememberMe = val),
                  label: S.of(context)!.rememberMe,
                ),
                const SizedBox(height: 24),

                // Login Button
                CustomButton(
                  label: isLoading ? "..." : S.of(context)!.login,
                  onPressed: isLoading ? null : _login,
                ),

                const SizedBox(height: 20),

                // Go to Register
                TextButton(
                  onPressed: _goToRegister,
                  child: Text(
                    S.of(context)!.noAccount,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),

                const SizedBox(height: 32),

                // 🔥 Sosyal Giriş Butonları (Google, Apple, Facebook)
                SocialLoginRow(
                  onGoogleTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Google Login tapped")),
                    );
                  },
                  onAppleTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Apple Login tapped")),
                    );
                  },
                  onFacebookTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Facebook Login tapped")),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
