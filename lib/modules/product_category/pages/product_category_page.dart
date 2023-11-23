
import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/product_category/services/product_category_service.dart';
import 'package:ecommerce/shared/widgets/app_bar_widget.dart';
import 'package:ecommerce/shared/widgets/badge_cart_widget.dart';
import 'package:ecommerce/shared/widgets/card_product_widget.dart';
import 'package:flutter/material.dart';

class ProductCategoryPage extends StatelessWidget {
  const ProductCategoryPage({
    super.key,
    this.idCategory,
    this.nameCategory,
  });

  final int? idCategory;
  final String? nameCategory;

  @override
  Widget build(BuildContext context) {
    ProductCategoryService productCategory = ProductCategoryService();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.blueGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          title: nameCategory ?? 'Productos',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
          actions: const [BadgeCartWidget()],
        ),
      ),
      body: FutureBuilder(
        future: productCategory.getProductCategoryId(idCategory ?? 0),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            if (data.isEmpty) {
              return const Center(
                child: Text('No se encontraron productos.'),
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: size.width / (size.height * 0.69),
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return CardProductWidget(product: product);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
