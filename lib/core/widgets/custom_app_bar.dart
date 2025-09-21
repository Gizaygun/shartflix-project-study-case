import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final VoidCallback? onOfferTap;
  final String? offerTooltip;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onOfferTap,
    this.offerTooltip,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 0.2,
        ),
      ),
      actions: [
        if (actions != null) ...actions!,
        if (onOfferTap != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              tooltip: offerTooltip,
              icon: const Icon(
                Icons.local_activity,
                color: Colors.white,
                size: 24,
              ),
              onPressed: onOfferTap,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
