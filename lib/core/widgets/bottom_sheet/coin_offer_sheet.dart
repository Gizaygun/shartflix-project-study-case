import 'package:flutter/material.dart';
import 'package:shartflix/l10n/S.dart';

/// KULLANIM:
/// final choice = await showCoinOfferSheet(context);
/// if (choice != null) { /* 'weekly' | 'monthly' seçimi */ }
Future<String?> showCoinOfferSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => const _CoinOfferSheet(),
  );
}

class _CoinOfferSheet extends StatefulWidget {
  const _CoinOfferSheet();

  @override
  State<_CoinOfferSheet> createState() => _CoinOfferSheetState();
}

class _CoinOfferSheetState extends State<_CoinOfferSheet> {
  String _selected = 'weekly'; // 'weekly' | 'monthly'

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final h = (media.size.height * 0.92).clamp(520.0, 820.0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      height: h,
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Color(0xFF0F0F0F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          double s(double x) => x * (c.maxWidth / 390.0);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: s(10)),
              Center(
                child: Container(
                  width: s(44),
                  height: s(5),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(s(3)),
                  ),
                ),
              ),
              SizedBox(height: s(16)),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: s(20)),
                child: Text(
                  S.of(context)!.limitedOffer,
                  style: TextStyle(
                    fontSize: s(34),
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: s(6)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: s(20)),
                child: Text(
                  S.of(context)!.coinOption,
                  style: TextStyle(
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ),
              SizedBox(height: s(12)),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: s(20)),
                  children: [
                    _CoinOptionCard(
                      s: s,
                      selected: _selected == 'weekly',
                      onTap: () => setState(() => _selected = 'weekly'),
                      badgeText: '+70%',
                      oldValue: '2.000',
                      mainValue: '3.375',
                      unit: S.of(context)!.unitCoin,
                      price: '₺799,99',
                      priceSub: S.of(context)!.weeklyPriceSub,
                    ),
                    SizedBox(height: s(18)),
                    _CoinOptionCard(
                      s: s,
                      selected: _selected == 'monthly',
                      onTap: () => setState(() => _selected = 'monthly'),
                      badgeText: '+70%',
                      oldValue: '10.000',
                      mainValue: '16.999',
                      unit: S.of(context)!.unitCoin,
                      price: '₺2.999,99',
                      priceSub: S.of(context)!.monthlyPriceSub,
                    ),
                    SizedBox(height: s(8)),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(s(20), s(6), s(20), s(16)),
                child: _CtaButton(
                  s: s,
                  text: _selected == 'weekly'
                      ? S.of(context)!.weeklyPackageCta
                      : S.of(context)!.monthlyPackageCta,
                  onTap: () => Navigator.of(context).pop(_selected),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CoinOptionCard extends StatelessWidget {
  final double Function(double) s;
  final bool selected;
  final VoidCallback onTap;
  final String badgeText;
  final String oldValue;
  final String mainValue;
  final String unit;
  final String price;
  final String priceSub;

  const _CoinOptionCard({
    required this.s,
    required this.selected,
    required this.onTap,
    required this.badgeText,
    required this.oldValue,
    required this.mainValue,
    required this.unit,
    required this.price,
    required this.priceSub,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF5949E6);
    const red = Color(0xFFE50914);

    final double cardW = s(186);
    final double cardH = s(220);
    final radius = BorderRadius.circular(s(16));

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: SizedBox(
          width: cardW,
          height: cardH,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  gradient: const RadialGradient(
                    center: Alignment(-0.6, -0.7),
                    radius: 1.2,
                    colors: [purple, red],
                  ),
                  border: Border.all(color: Colors.white, width: s(2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.25),
                      blurRadius: s(15),
                      offset: Offset(s(4), s(4)),
                      spreadRadius: s(-2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.10),
                              Colors.white.withOpacity(0.00),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(s(16), s(28), s(16), s(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            oldValue,
                            style: TextStyle(
                              color: Colors.white70,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.white70,
                              fontWeight: FontWeight.w600,
                              fontSize: s(18),
                              height: 1.0,
                            ),
                          ),
                          SizedBox(height: s(6)),
                          SizedBox(
                            height: s(60),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                mainValue,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: s(48),
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: s(6)),
                          Text(
                            unit,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: s(16),
                              height: 1.0,
                            ),
                          ),
                          SizedBox(height: s(10)),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.white.withOpacity(0.12),
                          ),
                          SizedBox(height: s(10)),
                          Text(
                            price,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: s(16),
                              height: 1.0,
                            ),
                          ),
                          SizedBox(height: s(4)),
                          Text(
                            priceSub,
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                              fontSize: s(13),
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: -s(12),
                left: 0,
                right: 0,
                child: Center(
                  child: IntrinsicWidth(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: s(61)),
                      child: Container(
                        height: s(23),
                        padding: EdgeInsets.symmetric(
                          vertical: s(4),
                          horizontal: s(20.19),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5949E6),
                          borderRadius: BorderRadius.circular(s(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.45),
                              blurRadius: s(8.33),
                              spreadRadius: -s(2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: s(12.5),
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              if (selected)
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: radius,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.18),
                            blurRadius: s(24),
                            spreadRadius: s(3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CtaButton extends StatefulWidget {
  final double Function(double) s;
  final String text;
  final VoidCallback onTap;
  const _CtaButton({required this.s, required this.text, required this.onTap});

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.s;
    return GestureDetector(
      onTapDown: (_) => setState(() => _down = true),
      onTapCancel: () => setState(() => _down = false),
      onTapUp: (_) => setState(() => _down = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: s(56),
        decoration: BoxDecoration(
          color: const Color(0xFFE50914),
          borderRadius: BorderRadius.circular(s(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_down ? 0.2 : 0.35),
              blurRadius: s(_down ? 6 : 12),
              offset: Offset(0, s(_down ? 2 : 6)),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: s(16),
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
