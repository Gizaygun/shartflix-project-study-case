import 'package:flutter/material.dart';

class CustomNavBarItem extends StatelessWidget {
  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final bool active;
  final VoidCallback onTap;

  const CustomNavBarItem({
    super.key,
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(42),
            gradient: active
                ? const LinearGradient(
              colors: [Color(0xFFE50914), Color(0xFF7F050B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
                : null,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            color: active ? null : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                active ? activeIcon : inactiveIcon,
                color: active ? Colors.white : Colors.white70,
                size: 22,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
