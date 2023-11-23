
import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.red,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pagina no encontrada'),
            FilledButtonWidget(
              text: 'Volver',
              onPressed: () => GlobalHelper.navigateToPageRemove(context, '/'),
            ),
          ],
        ),
      ),
    );
  }
}
