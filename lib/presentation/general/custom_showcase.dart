import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcase extends StatelessWidget {
  const CustomShowcase({
    super.key,
    required this.showcaseKey,
    required this.child,
    required this.description,
    required this.title,
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
  });

  final GlobalKey showcaseKey;
  final Widget child;
  final String title;
  final String description;
  final BorderRadius borderRadius;
  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: showcaseKey,
      title: title,
      descriptionPadding: const EdgeInsets.symmetric(vertical: 5),
      description: description,
      // disableMovingAnimation: true,
      disableScaleAnimation: true,
      targetBorderRadius: borderRadius,
      targetPadding: const EdgeInsets.all(4),
      tooltipBackgroundColor: Theme.of(context).inputDecorationTheme.fillColor!,
      blurValue: 4,
      tooltipPadding: const EdgeInsets.all(15),
      tooltipBorderRadius: BorderRadius.circular(5),
      movingAnimationDuration: const Duration(seconds: 5),
      child: child,
    );
  }
}
