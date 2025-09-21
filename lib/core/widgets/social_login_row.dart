import 'package:flutter/material.dart';

class SocialLoginRow extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final VoidCallback onFacebookTap;

  const SocialLoginRow({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
    required this.onFacebookTap,
  });

  Widget _buildIconButton({
    required String assetPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: const SizedBox(
        width: 48,
        height: 48,
        child: Center(

          child: _IconImage(),
        ),
      ),
    )._withAsset(assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconButton(
          assetPath: "assets/icons/google.png",
          onTap: onGoogleTap,
        ),
        const SizedBox(width: 24),
        _buildIconButton(
          assetPath: "assets/icons/apple.png",
          onTap: onAppleTap,
        ),
        const SizedBox(width: 24),
        _buildIconButton(
          assetPath: "assets/icons/facebook.png",
          onTap: onFacebookTap,
        ),
      ],
    );
  }
}


class _IconImage extends StatelessWidget {
  const _IconImage();

  @override
  Widget build(BuildContext context) {

    final provider = _IconAsset.of(context);
    return Image.asset(
      provider.assetPath,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}

class _IconAsset extends InheritedWidget {
  final String assetPath;
  const _IconAsset({
    required this.assetPath,
    required super.child,
    super.key,
  });

  static _IconAsset of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<_IconAsset>();
    assert(result != null, 'Icon asset not found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant _IconAsset oldWidget) =>
      oldWidget.assetPath != assetPath;
}


extension _WithAsset on Widget {
  Widget _withAsset(String assetPath) =>
      _IconAsset(assetPath: assetPath, child: this);
}
