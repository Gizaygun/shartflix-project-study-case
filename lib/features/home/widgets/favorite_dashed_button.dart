import 'package:flutter/material.dart';

class FavoriteDashedButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const FavoriteDashedButton({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Size size = Size(92, 204);
    const double radius = 5.0;
    const double stroke = 1.0;
    const double dash = 5.0;
    const double gap  = 5.0;
    const Color borderColor = Color(0x108A38F5);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: GestureDetector(
        onTap: onTap,
        child: CustomPaint(
          painter: _DashedRRectPainter(
            color: borderColor,
            strokeWidth: stroke,
            dashLength: dash,
            gapLength: gap,
            radius: radius,
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isActive
                  ? const Icon(Icons.favorite, key: ValueKey('on'), size: 28, color: Color(0xFFE50914))
                  : const Icon(Icons.favorite_border, key: ValueKey('off'), size: 28, color: Colors.white70),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;
  final double radius;

  _DashedRRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth;

    final path = Path()..addRRect(rrect);
    final dashed = _dashPath(path, dashLength, gapLength);
    canvas.drawPath(dashed, paint);
  }

  Path _dashPath(Path source, double dashLength, double gapLength) {
    final Path dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double next = distance + dashLength;
        dest.addPath(metric.extractPath(distance, next.clamp(0.0, metric.length)), Offset.zero);
        distance = next + gapLength;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) =>
      old.color != color ||
          old.strokeWidth != strokeWidth ||
          old.dashLength != dashLength ||
          old.gapLength != gapLength ||
          old.radius != radius;
}
