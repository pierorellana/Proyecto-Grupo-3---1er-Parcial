
import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DiscountLabelWidget extends StatelessWidget {
  const DiscountLabelWidget({
    super.key,
    this.width = 0.15,
    this.fontSize = 12,
    required this.discount,
  });

  final double? width;
  final double? fontSize;
  final String discount;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * width!,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.red,
      ),
      child: Text(
        discount,
        style: TextStyle(
          color: AppTheme.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
