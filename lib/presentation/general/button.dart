import 'package:flutter/material.dart';

class AyatiButton extends StatelessWidget {
  const AyatiButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isOutlined = false,
    this.isSmall = false,
  });

  final VoidCallback onTap;
  final String text;
  final bool isOutlined;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? 100 : MediaQuery.of(context).size.width * 0.75,
      height: isSmall ? 35 : 50,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onTap,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            )
          : FilledButton(
              onPressed: onTap,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
    );
  }
}
