import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/auth/pages/login/login_page.dart';
import 'package:ecommerce/modules/auth/services/auth_service.dart';
import 'package:ecommerce/modules/cart/services/cart_service.dart';
import 'package:ecommerce/modules/cart/widgets/icon_button_widget.dart';
import 'package:ecommerce/modules/cart/widgets/total_price_detail_widget.dart';
import 'package:ecommerce/modules/home/models/products_response.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/models/product_model.dart';
import 'package:ecommerce/shared/widgets/alert_dialog_widget.dart';
import 'package:ecommerce/shared/widgets/app_bar_widget.dart';
import 'package:ecommerce/shared/widgets/discount_label_widget.dart';
import 'package:ecommerce/shared/widgets/drawer_widget.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:ecommerce/shared/widgets/leading_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/functional_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  AuthService authService = AuthService();
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    // // authService.getCredentials().then((user) {
    // //   setState(() {
    // //     isLogged = user[0].isLogged;
    //  });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartService>(context);
    final String subtotal = cartProvider.subtotalCart();
    final String iva = cartProvider.ivaCart();
    final String total = cartProvider.totalCart();
    final String totalItems = cartProvider.carProducts.length.toString();
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);

    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.centerEnd,
      backgroundColor: AppTheme.blueGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(
          leading: LeadingButtonWidget(keyPage: widget.keyPage,),
          title: '($totalItems)',
          centerTitle: false,
          actions: [_EmptyCart(cartProvider: cartProvider, keyPage: widget.keyPage)],
        ),
      ),
      persistentFooterButtons: cartProvider.carProducts.isNotEmpty
          ? [
              const TotalpriceDetail(
                fontWeight: FontWeight.bold,
                crossAxisAlignment: CrossAxisAlignment.end,
                subtotal: 'Subtotal:',
                iva: 'IVA 12%:',
                total: 'Total:',
              ),
              TotalpriceDetail(
                crossAxisAlignment: CrossAxisAlignment.start,
                subtotal: '\$$subtotal',
                iva: '\$$iva',
                total: '\$$total',
              ),
              FilledButtonWidget(
                text: 'Comprar',
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialogWidget(
                        key: const Key('comprar'),
                        alertTitle: 'Confirmar compra',
                        alertContent:
                            '¿Está seguro que desea realizar la compra?',
                        onPressed: () {
                          if (DrawerWidget.isLogged) {
                            Navigator.of(context).pop();
                            fp.dismissAlert(key: widget.keyPage);
                            //GlobalHelper.navigateToPageRemove(context, '/');
                            cartProvider.emptyCart();
                            GlobalHelper.showSnackBar(
                                context, 'Compra realizada con éxito.');
                          } else {
                            final pageLoginKey = GlobalHelper.genKey();
                             Navigator.of(context).pop();
                            // GlobalHelper.navigateToPage(context, '/login');
                            fp.addPage(
                                key: pageLoginKey,
                                content: LoginPage(
                                    keyPage: pageLoginKey,
                                    key: pageLoginKey));
                                    
                            GlobalHelper.showSnackBar(context,
                                'Debe iniciar sesión para realizar la compra.');
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ]
          : [],
      body: Center(
        child: cartProvider.carProducts.isEmpty
            ? const Text('El carrito esta vacio, por favor agrega productos')
            : ListView.builder(
                clipBehavior: Clip.antiAlias,
                itemCount: cartProvider.carProducts.length,
                itemBuilder: (context, index) {
                  final product = cartProvider.carProducts[index];
                  return Card(
                    surfaceTintColor: AppTheme.white,
                    color: AppTheme.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: AppTheme.borderGrey, width: 0.20),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              FadeInImage(
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return const Image(
                                    image: AssetImage('assets/no-image.png'),
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  );
                                },
                                imageSemanticLabel: product.name,
                                placeholder:
                                    const AssetImage('assets/loading.gif'),
                                image: NetworkImage(
                                  product.image,
                                ),
                                fit: BoxFit.cover,
                                width: 70,
                                height: 70,
                              ),
                              if (product.offer == 1)
                                Positioned(
                                  top: size.height * 0.003,
                                  right: size.width * 0.01,
                                  child: DiscountLabelWidget(
                                    discount: product.discountLabel,
                                    width: 0.1,
                                    fontSize: 8,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        _NameAndPriceProduct(product: product),
                        _ProductQuantity(
                            cartProvider: cartProvider, product: product)
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _ProductQuantity extends StatelessWidget {
  const _ProductQuantity({
    required this.cartProvider,
    required this.product,
  });

  final CartService cartProvider;
  final Products product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButtonWidget(
          color: AppTheme.red,
          onPressed: () {
            cartProvider.deleteProduct(product);
          },
          icon: Icons.remove_circle,
        ),
        Text(
          product.amount.toString(),
          style: const TextStyle(
            color: AppTheme.black,
            fontSize: 15,
          ),
        ),
        IconButtonWidget(
          color: AppTheme.black,
          icon: Icons.add_circle,
          onPressed: () {
            if (product.amount >= 5) {
              GlobalHelper.showSnackBar(context,
                  'No puedes agregar mas de 5 productos del mismo tipo.');
            } else {
              cartProvider.addCartProduct(product);
            }
          },
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.cartProvider, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  final CartService cartProvider;

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return TextButton.icon(
      label: const Text(
        'Vaciar Carrito',
        style: TextStyle(color: AppTheme.black),
      ),
      onPressed: () {
        if (cartProvider.carProducts.isNotEmpty) {
          cartProvider.emptyCart();
          fp.dismissAlert(key: keyPage);
          //GlobalHelper.navigateToPageRemove(context, '/');
          GlobalHelper.showSnackBar(
              context, 'El carrito de compras se ha vaciado.');
        } else {
          GlobalHelper.showSnackBar(
              context, 'El carrito de compras ya se encuentra vacío.');
        }
      },
      icon: const Icon(
        Icons.delete_outline,
        color: AppTheme.red,
      ),
    );
  }
}

class _NameAndPriceProduct extends StatelessWidget {
  const _NameAndPriceProduct({required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Text(
            product.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ),
        if (product.offer == 0)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
                "\$${(double.parse(product.price) * product.amount).toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          )
        else
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Row(
              children: [
                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppTheme.red,
                    decorationThickness: 2.0,
                    color: AppTheme.black45,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                    "\$${(double.parse(product.offerPrice) * product.amount).toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
      ],
    );
  }
}
