import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/cart/services/cart_service.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/models/product_model.dart';
import 'package:ecommerce/shared/widgets/discount_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardProductWidget extends StatelessWidget {
  const CardProductWidget({super.key, required this.product});
  final Products product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cartService = Provider.of<CartService>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: AppTheme.white,
        surfaceTintColor: AppTheme.white,
        clipBehavior: Clip.none,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: AppTheme.borderGrey, width: 0.20),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: FadeInImage(
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image(
                    image: const AssetImage('assets/no-image.png'),
                    width: size.width,
                    height: size.height * 0.2,
                    fit: BoxFit.fill,
                  );
                },
                imageSemanticLabel: product.name,
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(
                  product.image,
                ),
                width: size.width,
                height: size.height * 0.2,
                fit: BoxFit.fill,
              ),
            ),
            if (product.offer == 1)
              Positioned(
                top: size.height * 0.01,
                left: size.width * 0.015,
                child: DiscountLabelWidget(
                  discount: product.discountLabel,
                ),
              ),
            Positioned(
              top: size.height * 0.2,
              left: size.width * 0.01,
              right: size.width * 0.01,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTheme.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  product.offer == 1
                      ? Row(
                          children: [
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppTheme.red,
                                decorationThickness: 2,
                                fontSize: 14,
                                color: AppTheme.black45,
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              '\$${product.offerPrice}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      : Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ],
              ),
            ),
            Positioned(
              left: size.width * 0.01,
              right: size.width * 0.01,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      cartService.addCartProduct(product);
                      GlobalHelper.showSnackBar(
                          context, 'Producto agregado al carrito');
                    },
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: AppTheme.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.favorite_border, color: AppTheme.red),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
