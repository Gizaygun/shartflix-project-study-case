import 'package:flutter/material.dart';
import 'package:shartflix/l10n/S.dart';
import '../widgets/custom_nav_bar_item.dart';

class NavBarView extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBarView({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.black,
      child: Row(
        children: [
          CustomNavBarItem(
            label: S.of(context)!.homeNav, // ✅ Localization
            activeIcon: Icons.home,
            inactiveIcon: Icons.home_outlined,
            active: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          CustomNavBarItem(
            label: S.of(context)!.profileNav, // ✅ Localization
            activeIcon: Icons.person,
            inactiveIcon: Icons.person_outline,
            active: currentIndex == 1,
            onTap: () => onTap(1),
          ),
        ],
      ),
    );
  }
}
