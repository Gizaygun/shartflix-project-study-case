import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_theme.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/favorites_provider.dart';
import 'features/nav_bar/main_shell.dart';
import 'features/auth/views/login_view.dart';
import 'l10n/S.dart';
import 'l10n/l10n.dart';

// 🔑 uygulama buradan başlar
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,

        // ✅ Localization
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        locale: const Locale('tr'),

        initialRoute: "/login",
        routes: {
          "/login": (_) => LoginView(),
          "/main": (_) => const MainShell(),
        },
      ),
    );
  }
}
