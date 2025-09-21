import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_theme.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/favorites_provider.dart';
import 'core/providers/locale_provider.dart';

import 'features/auth/views/login_view.dart';
import 'features/auth/views/register_view.dart';
import 'features/nav_bar/view/main_shell.dart';
import 'features/splash/views/splash_view.dart';

import 'l10n/S.dart';
import 'l10n/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProv, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            locale: localeProv.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            initialRoute: '/',

            // Route tablosu
            routes: {
              '/': (_) => const SplashView(),
              '/login': (_) => const LoginView(),
              '/register': (_) => const RegisterView(),
              '/main': (_) => const MainShell(),
            },
          );
        },
      ),
    );
  }
}
