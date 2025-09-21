import 'package:flutter/material.dart';
import 'package:shartflix/core/network/token_storage.dart';
import 'package:shartflix/core/network/api_client.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _stripeCtrl;
  late final AnimationController _fadeCtrl;

  @override
  void initState() {
    super.initState();

    _stripeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _decideRoute();
  }

  Future<void> _decideRoute() async {
    final t = await TokenStorage.read();
    if (t != null && t.isNotEmpty) {
      ApiClient().setToken(t);
    }
    await Future.delayed(const Duration(milliseconds: 2400));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, t == null ? '/login' : '/main');
  }

  @override
  void dispose() {
    _stripeCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🔴 Arka plan radial gradient (kırmızı glow)
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.25,
                colors: [
                  Color(0xFFE50914), // Netflix kırmızı
                  Color(0xFF000000), // Siyah
                ],
                stops: [0.25, 1.0],
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.55)),

          // 🅂 Büyük "S" harfi (kırmızı şerit animasyonu)
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  "S",
                  style: TextStyle(
                    fontSize: 210,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                AnimatedBuilder(
                  animation: _stripeCtrl,
                  builder: (context, _) {
                    return ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: _stripeCtrl.value,
                        child: const Text(
                          "S",
                          style: TextStyle(
                            fontSize: 210,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFE50914),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),


          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.28,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeCtrl,
              child: const Text(
                "Shartflix",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.4,
                  color: Colors.white,
                ),
              ),
            ),
          ),


          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Loading…',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
