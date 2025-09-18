import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  String locale = 'tr';
  String? profilePhotoUrl;
  final Set<int> favorites = {};

  void toggleLocale() { locale = locale == 'tr' ? 'en' : 'tr'; notifyListeners(); }
  void setProfilePhoto(String? url) { profilePhotoUrl = url; notifyListeners(); }
  void toggleFavorite(int index) {
    if (favorites.contains(index)) { favorites.remove(index); }
    else { favorites.add(index); }
    notifyListeners();
  }
}

class AppState extends InheritedWidget {
  final AppController controller;
  const AppState({super.key, required this.controller, required super.child});

  static AppController of(BuildContext context) {
    final AppState? state = context.dependOnInheritedWidgetOfExactType<AppState>();
    assert(state != null, 'AppState not found in context');
    return state!.controller;
  }

  @override
  bool updateShouldNotify(covariant AppState oldWidget) =>
      controller != oldWidget.controller;
}
