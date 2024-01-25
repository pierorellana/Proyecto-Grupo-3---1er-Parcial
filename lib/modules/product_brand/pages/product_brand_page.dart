
// import 'package:ecommerce/env/theme/app_theme.dart';
// import 'package:ecommerce/modules/product_brand/services/product_brand_service.dart';
// import 'package:ecommerce/shared/widgets/app_bar_widget.dart';
// import 'package:ecommerce/shared/widgets/badge_cart_widget.dart';
// import 'package:ecommerce/shared/widgets/card_product_widget.dart';
// import 'package:flutter/material.dart';

// class ProductBrandPage extends StatelessWidget {
//   const ProductBrandPage({
//     super.key,
//     this.idBrand,
//     this.nameBrand,
//   });

//   final int? idBrand;
//   final String? nameBrand;

//   @override
//   Widget build(BuildContext context) {
//     ProductBrandService products = ProductBrandService();
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: AppTheme.blueGrey,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBarWidget(
//           title: nameBrand ?? 'Productos',
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_new),
//             onPressed: () => Navigator.pop(context),
//           ),
//           actions: const [BadgeCartWidget()],
//         ),
//       ),
//       body: FutureBuilder(
//         future: products.getProductBrandId(idBrand ?? 0),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final data = snapshot.data!;
//             if (data.isEmpty) {
//               return const Center(
//                 child: Text('No se encontraron productos.'),
//               );
//             }
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: size.width / (size.height * 0.69),
//               ),
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final product = snapshot.data![index];
//                 return CardProductWidget(product: product);
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
