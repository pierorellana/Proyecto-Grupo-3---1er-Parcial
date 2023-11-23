import 'package:flutter/material.dart';

class TotalpriceDetail extends StatelessWidget {
  const TotalpriceDetail({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.subtotal,
    required this.iva,
    required this.total,
    this.fontWeight = FontWeight.normal,
  });

  final CrossAxisAlignment crossAxisAlignment;
  final String subtotal;
  final String iva;
  final String total;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(subtotal, style: TextStyle(fontWeight: fontWeight)),
        Text(iva, style: TextStyle(fontWeight: fontWeight)),
        Text(total, style: TextStyle(fontWeight: fontWeight)),
      ],
    );
  }
}
