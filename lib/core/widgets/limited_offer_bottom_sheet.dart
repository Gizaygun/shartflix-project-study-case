import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'custom_button.dart';

Future<String?> showLimitedOfferSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => const _LimitedOfferSheet(),
  );
}

class _LimitedOfferSheet extends StatefulWidget {
  const _LimitedOfferSheet();

  @override
  State<_LimitedOfferSheet> createState() => _LimitedOfferSheetState();
}

class _LimitedOfferSheetState extends State<_LimitedOfferSheet> {
  String _selectedPlan = 'monthly';
  int _secondsLeft = 180; // 3 dakika

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      if (_secondsLeft <= 0) return false;
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() => _secondsLeft--);
      }
      return true;
    });
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Timer
          Text(
            _formatTime(_secondsLeft),
            style: AppTextStyles.heading2.copyWith(color: AppColors.error),
          ),
          const SizedBox(height: 24),

          // Coin Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCoinOption("monthly", "Aylık", "₺49.99"),
              _buildCoinOption("yearly", "Yıllık", "₺499.99"),
            ],
          ),
          const SizedBox(height: 32),

          // Continue button
          CustomButton(
            label: "Devam Et",
            onPressed: () {
              Navigator.pop(context, _selectedPlan);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCoinOption(String key, String title, String price) {
    final isSelected = _selectedPlan == key;

    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = key),
      child: Container(
        width: 116,
        height: 186,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: AppColors.coinGradient,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: -4,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Jeton",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
            const SizedBox(height: 8),
            Text(title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
            const SizedBox(height: 8),
            Text(price,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                )),
            if (isSelected) ...[
              const SizedBox(height: 12),
              const Icon(Icons.check_circle, color: Colors.white, size: 24),
            ],
          ],
        ),
      ),
    );
  }
}
