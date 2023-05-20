import 'package:ayat_notifications/utils/enum.dart';
import 'package:flutter/material.dart';

class AyatiLogo extends StatelessWidget {
  const AyatiLogo({
    super.key,
    required this.type,
    required this.size,
  });

  final AyatiLogoType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      type.path,
      width: size,
      height: size,
    );
  }
}
