import 'package:ayat_notifications/utils/colors.dart';
import 'package:flutter/material.dart';

class SlideNavigationIconButton extends StatelessWidget {
  const SlideNavigationIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.grey.withOpacity(.5),
      ),
    );
  }
}
