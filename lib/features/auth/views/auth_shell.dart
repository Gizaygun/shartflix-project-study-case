import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import 'login_view.dart';
import 'register_view.dart';

class AuthShell extends StatefulWidget {
  const AuthShell({super.key});

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              height: 160,
              child: Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_jcikwtux.json',
                repeat: true,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: showLogin
                    ? const LoginView(key: ValueKey('login'))
                    : const RegisterView(key: ValueKey('register')),
              ),
            ),
            TextButton(
              onPressed: () => setState(() => showLogin = !showLogin),
              child: Text(
                showLogin
                    ? t(context, 'no_account')
                    : t(context, 'have_account'),
                style: const TextStyle(color: Colors.grey), // ✅ düzeltildi
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
