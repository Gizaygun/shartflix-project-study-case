import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.watch<LocaleProvider>().locale?.languageCode ?? 'system';

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language, color: Colors.white),
      tooltip: 'Dil / Language',
      onSelected: (code) {
        if (code == 'system') {
          context.read<LocaleProvider>().clearLocale();
        } else {
          context.read<LocaleProvider>().setLocale(Locale(code));
        }
      },
      itemBuilder: (ctx) => const [
        PopupMenuItem(value: 'system', child: Text('System Default')),
        PopupMenuItem(value: 'tr', child: Text('Türkçe')),
        PopupMenuItem(value: 'en', child: Text('English')),
      ],
    );
  }
}
