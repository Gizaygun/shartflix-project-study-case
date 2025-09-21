import 'package:flutter/material.dart';
import 'package:shartflix/features/home/views/home_view.dart';
import 'package:shartflix/features/profile/views/profile_view.dart';
import 'package:shartflix/features/nav_bar/view/nav_bar_view.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavBarView(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() => _currentIndex = i);
        },
      ),
    );
  }
}
