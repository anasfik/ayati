import 'package:flutter/material.dart';

class MarginedBody extends StatelessWidget {
  const MarginedBody({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
    required this.child,
  });

  final EdgeInsetsGeometry margin;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, child: child);
  }
}
