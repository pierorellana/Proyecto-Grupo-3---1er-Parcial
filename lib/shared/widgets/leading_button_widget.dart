import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/functional_provider.dart';

class LeadingButtonWidget extends StatelessWidget {
  const LeadingButtonWidget({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () => fp.dismissAlert(key: keyPage),
    );
  }
}
