import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: AppTheme.blueGrey,
      centerTitle: centerTitle,
      leading: leading,
      iconTheme: const IconThemeData(color: AppTheme.black),
      actions: actions,
      title: Text(
        title,
        style: const TextStyle(
          color: AppTheme.black,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
