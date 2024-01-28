import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      this.textAlign = TextAlign.start,
      this.keyboardType,
      this.hintText,
      this.maxWidth = double.infinity,
      this.controller,
      this.validator,
      this.inputFormatters,
      this.textInputAction,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly = false,
      this.obscureText = false});

  final double maxWidth;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppTheme.borderGrey.withOpacity(0.4),
                spreadRadius: 1.5,
                blurRadius: 3.5,
                offset: const Offset(0, 2.5),
              ),
            ],
          ),
          child: SizedBox(height: 45, width: maxWidth),
        ),
        TextFormField(
          readOnly: readOnly!,
          obscureText: obscureText,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          validator: validator,
          controller: controller,
          textAlign: textAlign,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            alignLabelWithHint: true,
            isCollapsed: false,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
            constraints: BoxConstraints(maxWidth: maxWidth),
            border: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 0.2, color: AppTheme.borderGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppTheme.black.withOpacity(0.6),
                fontWeight: FontWeight.normal),
            filled: true,
            fillColor: AppTheme.white,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 0.2, color: AppTheme.borderGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 0.2, color: AppTheme.borderGrey),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
