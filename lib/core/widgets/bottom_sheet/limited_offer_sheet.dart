import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

void showLimitedOffer(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'Offer',
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, __, ___) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          sizeFactor: curved,
          axisAlignment: -1,
          child: const _LimitedOfferCard(),
        ),
      );
    },
  );
}

class _LimitedOfferCard extends StatelessWidget {
  const _LimitedOfferCard();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width.clamp(320.0, 600.0);
    return Material(
      color: Colors.transparent,
      child: Container(
        width: w,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 16)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_offer, color: AppColors.primary, size: 36),
            const SizedBox(height: 8),
            Text('Sınırlı Teklif',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary)),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: _PlanTile(title: 'Aylık', price: '₺79', selected: true)),
                SizedBox(width: 12),
                Expanded(child: _PlanTile(title: 'Yıllık', price: '₺699', selected: false)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 48, width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: () => Navigator.pop(context),
                child: const Text('Devam Et',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  final String title; final String price; final bool selected;
  const _PlanTile({required this.title, required this.price, required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? AppColors.primary : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(price, style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ],
      ),
    );
  }
}
