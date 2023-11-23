import 'package:flutter/material.dart';

class LeadingButtonWidget extends StatelessWidget {
  const LeadingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
