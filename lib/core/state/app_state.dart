import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String? profilePhotoUrl;
  final Set<int> favorites = <int>{};

  void setProfilePhoto(String? url) {
    profilePhotoUrl = url;
    notifyListeners();
  }

  void toggleFavorite(int index) {
    if (favorites.contains(index)) {
      favorites.remove(index);
    } else {
      favorites.add(index);
    }
    notifyListeners();
  }
}

// Basit, global bir scope için InheritedWidget
class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState notifier,
    required Widget child,
  }) : super(notifier: notifier, child: child);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in context');
    return scope!.notifier!;
  }
}
