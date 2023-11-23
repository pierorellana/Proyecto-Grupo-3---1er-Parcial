
import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    required this.alertTitle,
    required this.alertContent,
    this.onPressed,
  });

  final String alertTitle;
  final String alertContent;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      backgroundColor: AppTheme.white,
      surfaceTintColor: AppTheme.white,
      contentPadding: const EdgeInsets.only(top: 25, bottom: 20),
      actionsAlignment: MainAxisAlignment.spaceAround,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            color: AppTheme.blueDark,
            child: Text(
              alertTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              alertContent,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.black,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(
              color: AppTheme.red,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        FilledButtonWidget(
          radius: 20,
          onPressed: onPressed,
          text: 'Aceptar',
        )
      ],
    );
  }
}
