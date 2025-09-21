import 'package:flutter/material.dart';
import '../network/api_client.dart';
import '../network/token_storage.dart';

Future<void> appLogout(BuildContext context) async {
  // 1) Token'ı RAM'den sök
  ApiClient().setToken(null);
  // 2) Diskten sil
  await TokenStorage.clear();

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Çıkış yapıldı')),
    );
  }

  if (!context.mounted) return;
  Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
}
