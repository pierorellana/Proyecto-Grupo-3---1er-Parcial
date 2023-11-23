import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    super.key,
    this.onPressed,
    required this.text,
    this.radius = 10,
  });
  final void Function()? onPressed;
  final String text;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: AppTheme.blueDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
