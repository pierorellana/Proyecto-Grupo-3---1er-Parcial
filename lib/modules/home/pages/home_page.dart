import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

// import 'package:ecommerce/env/theme/app_theme.dart';
// import 'package:ecommerce/modules/home/services/home_service.dart';
// import 'package:ecommerce/modules/home/widgets/content_title_widget.dart';
// import 'package:ecommerce/modules/product_brand/pages/product_brand_page.dart';
// import 'package:ecommerce/modules/product_category/pages/product_category_page.dart';
// import 'package:ecommerce/shared/widgets/app_bar_widget.dart';
// import 'package:ecommerce/shared/widgets/badge_cart_widget.dart';
// import 'package:ecommerce/shared/widgets/card_product_widget.dart';
// import 'package:ecommerce/shared/widgets/drawer_widget.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   HomeService homeService = HomeService();

//   @override
//   void initState() {
//     super.initState();
//     //homeService.getBrands();
//     homeService.getProducts();
//     //homeService.getCategories();
//     homeService.getProductsOffer();
//     homeService.wantedProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: AppTheme.blueGrey,
//       drawer: const DrawerWidget(),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50),
//         child: AppBarWidget(
//           title: 'Ecommerce',
//           actions: const [BadgeCartWidget()],
//           leading: Builder(
//             builder: (context) => IconButton(
//               icon: const Icon(Icons.sort),
//               onPressed: () => Scaffold.of(context).openDrawer(),
//             ),
//           ),
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () {
//           setState(() {
//             //homeService.getBrands();
//             homeService.getProducts();
//             //homeService.getCategories();
//             homeService.wantedProducts();
//           });
//           return Future.delayed(const Duration(seconds: 1));
//         },
//         child: CustomScrollView(
//           slivers: [
//             _TextFormSearch(size: size),
//             // const _SizedBoxHeight(),
//             // const ContentTitleWidget(title: 'Categorias'),
//             // _Categories(size: size, homeService: homeService),
//             //const _SizedBoxHeight(),
//             // const ContentTitleWidget(title: 'Marcas'),
//             // _Brands(size: size, homeService: homeService),
//             const _SizedBoxHeight(),
//             const ContentTitleWidget(title: 'Ofertas'),
//             _ProductsOffer(homeService: homeService, size: size),
//             const ContentTitleWidget(title: 'Productos mas buscados'),
//             _ProductsWanted(homeService: homeService, size: size),
//             const ContentTitleWidget(title: 'Productos', top: 10),
//             _Products(homeService: homeService, size: size),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SizedBoxHeight extends StatelessWidget {
//   const _SizedBoxHeight();

//   @override
//   Widget build(BuildContext context) {
//     return const SliverToBoxAdapter(
//       child: SizedBox(height: 10),
//     );
//   }
// }

// class _TextFormSearch extends StatelessWidget {
//   const _TextFormSearch({required this.size});

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsets.only(
//           top: 5,
//           left: 10,
//           right: 10,
//         ),
//         child: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppTheme.borderGrey.withOpacity(0.4),
//                     spreadRadius: 1.5,
//                     blurRadius: 3.5,
//                     offset: const Offset(0, 2.5),
//                   ),
//                 ],
//               ),
//               child:
//                   SizedBox(height: size.height * 0.06, width: double.infinity),
//             ),
//             TextFormField(
//               readOnly: true,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(
//                     top: size.height * 0.01,
//                     left: size.width * 0.05,
//                     bottom: size.height * 0.01),
//                 hintText: 'Buscar',
//                 suffixIcon: Container(
//                     decoration: const BoxDecoration(
//                       color: AppTheme.blueDark,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(50),
//                         bottomRight: Radius.circular(50),
//                       ),
//                     ),
//                     child: const Icon(Icons.search, color: AppTheme.white)),
//                 border: OutlineInputBorder(
//                   borderSide:
//                       const BorderSide(width: 0.2, color: AppTheme.borderGrey),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 hintStyle: TextStyle(
//                     color: AppTheme.black.withOpacity(0.6),
//                     fontWeight: FontWeight.normal),
//                 filled: true,
//                 fillColor: AppTheme.white,
//                 enabledBorder: OutlineInputBorder(
//                   borderSide:
//                       const BorderSide(width: 0.2, color: AppTheme.borderGrey),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide:
//                       const BorderSide(width: 0.2, color: AppTheme.borderGrey),
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Products extends StatelessWidget {
//   const _Products({
//     required this.homeService,
//     required this.size,
//   });

//   final HomeService homeService;
//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: homeService.getProducts(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return SliverGrid.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: size.width / (size.height * 0.69),
//             ),
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final product = snapshot.data![index];
//               return CardProductWidget(
//                 product: product,
//               );
//             },
//           );
//         } else if (snapshot.hasError) {
//           return const SliverToBoxAdapter(
//             child: Center(
//               child: Text('Error al cargar los productos'),
//             ),
//           );
//         } else {
//           return const SliverToBoxAdapter(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// class _ProductsWanted extends StatelessWidget {
//   const _ProductsWanted({
//     required this.size,
//     required this.homeService,
//   });

//   final Size size;
//   final HomeService homeService;

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: SizedBox(
//         height: size.height * 0.34,
//         child: FutureBuilder(
//           future: homeService.wantedProducts(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Center(
//                   child: Text('Error al cargar los productos mas buscados'));
//             } else if (snapshot.hasData) {
//               return GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   mainAxisExtent: size.width * 0.5,
//                   crossAxisCount: 1,
//                   childAspectRatio: size.width / (size.height * 0.69),
//                 ),
//                 clipBehavior: Clip.none,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final product = snapshot.data![index];
//                   return CardProductWidget(
//                     product: product,
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class _ProductsOffer extends StatelessWidget {
//   const _ProductsOffer({
//     required this.size,
//     required this.homeService,
//   });

//   final Size size;
//   final HomeService homeService;

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: SizedBox(
//         height: size.height * 0.34,
//         child: FutureBuilder(
//           future: homeService.getProductsOffer(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Center(child: Text('Error al cargar las ofertas'));
//             } else if (snapshot.hasData) {
//               return GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   mainAxisExtent: size.width * 0.5,
//                   crossAxisCount: 1,
//                   childAspectRatio: size.width / (size.height * 0.69),
//                 ),
//                 clipBehavior: Clip.none,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final product = snapshot.data![index];
//                   return CardProductWidget(
//                     product: product,
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class _Brands extends StatelessWidget {
//   const _Brands({
//     required this.size,
//     required this.homeService,
//   });

//   final Size size;
//   final HomeService homeService;

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: SizedBox(
//         height: size.width * 0.2,
//         child: FutureBuilder(
//           future: homeService.getBrands(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Center(child: Text('Error al cargar las marcas'));
//             } else if (snapshot.hasData) {
//               return ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 clipBehavior: Clip.none,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final brand = snapshot.data![index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation, _) =>
//                               FadeTransition(
//                             opacity: animation,
//                             child: ProductBrandPage(
//                               idBrand: brand.id,
//                               nameBrand: brand.nombre,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5),
//                       child: Container(
//                         height: size.width * 0.2,
//                         width: size.width * 0.2,
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppTheme.borderGrey.withOpacity(0.4),
//                               spreadRadius: 1.5,
//                               blurRadius: 3.5,
//                               offset: const Offset(0, 2.5),
//                             ),
//                           ],
//                           shape: BoxShape.circle,
//                           color: AppTheme.white,
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(100),
//                           child: FadeInImage(
//                             imageErrorBuilder: (context, error, stack) {
//                               return const Image(
//                                 image: AssetImage('assets/no-image.png'),
//                               );
//                             },
//                             placeholder: const AssetImage('assets/loading.gif'),
//                             image: NetworkImage(brand.imagen),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class _Categories extends StatelessWidget {
//   const _Categories({
//     required this.size,
//     required this.homeService,
//   });

//   final Size size;
//   final HomeService homeService;

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: SizedBox(
//         height: size.width * 0.1,
//         child: FutureBuilder(
//           future: homeService.getCategories(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Center(
//                   child: Text('Error al cargar las categorias'));
//             } else if (snapshot.hasData) {
//               return ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 clipBehavior: Clip.none,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final category = snapshot.data![index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation, _) =>
//                               FadeTransition(
//                             opacity: animation,
//                             child: ProductCategoryPage(
//                               idCategory: category.id,
//                               nameCategory: category.nombre,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: AppTheme.borderGrey, width: 0.2),
//                           borderRadius: BorderRadius.circular(50),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppTheme.borderGrey.withOpacity(0.3),
//                               spreadRadius: 1,
//                               blurRadius: 3,
//                               offset: const Offset(0, 1),
//                             ),
//                           ],
//                           color: AppTheme.white,
//                         ),
//                         child: Text(category.nombre),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
