import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ContentTitleWidget extends StatelessWidget {
  const ContentTitleWidget({
    super.key,
    required this.title,
    this.top = 0,
    this.bottom = 0,
    this.left = 10,
    this.right = 0,
  });

  final String title;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
            top: top!, bottom: bottom!, left: left!, right: right!),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: AppTheme.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Ver más'),
            ),
          ],
        ),
      ),
    );
  }
}
