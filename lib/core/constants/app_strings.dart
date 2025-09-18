import 'package:flutter/material.dart';
import '../helpers/app_state.dart';

final _strings = <String, Map<String, String>>{
  'tr': {
    'app': 'Shartflix',
    'login': 'Giriş Yap',
    'register': 'Kayıt Ol',
    'email': 'E-posta',
    'password': 'Şifre',
    'no_account': 'Hesabın yok mu? Kayıt Ol',
    'have_account': 'Hesabın var mı? Giriş Yap',
    'home': 'Ana Sayfa',
    'profile': 'Profil',
    'limited_offer': 'Sınırlı Teklif',
    'choose_photo': 'Fotoğrafı Değiştir',
    'favorites': 'Beğenilenler',
    'lang': 'Dil',
    'no_favs': 'Henüz favori yok.',
  },
  'en': {
    'app': 'Shartflix',
    'login': 'Log In',
    'register': 'Register',
    'email': 'Email',
    'password': 'Password',
    'no_account': 'No account? Register',
    'have_account': 'Have an account? Log In',
    'home': 'Home',
    'profile': 'Profile',
    'limited_offer': 'Limited Offer',
    'choose_photo': 'Change Photo',
    'favorites': 'Favorites',
    'lang': 'Language',
    'no_favs': 'No favorites yet.',
  },
};

String t(BuildContext context, String key) {
  final app = AppState.of(context);
  return _strings[app.locale]?[key] ?? key;
}
