
import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/cart/services/cart_service.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BadgeCartWidget extends StatelessWidget {
  const BadgeCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartService>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -6, end: 6),
        badgeContent: Text(
          cartProvider.carProducts.length.toString(),
          style: const TextStyle(color: AppTheme.white, fontSize: 10),
        ),
        child: IconButton(
          onPressed: () {
            if (cartProvider.carProducts.isEmpty) {
              GlobalHelper.showSnackBar(
                  context, 'El carrito de compras está vacío.');
            } else {
              GlobalHelper.navigateToPage(context, '/cart');
            }
          },
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: AppTheme.black,
          ),
        ),
      ),
    );
  }
}
