import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/administration/pages/edit_product_page.dart';
import 'package:ecommerce/modules/administration/pages/new_product_page.dart';
import 'package:ecommerce/modules/administration/services/administration_service.dart';
import 'package:ecommerce/modules/home/services/home_service.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/functional_provider.dart';
import '../../../shared/widgets/app_bar_widget.dart';
import '../../../shared/widgets/leading_button_widget.dart';
import '../../home/models/products_response.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  List<Products>? products;
  final HomeService homeService = HomeService();
  final AdministrationService administrationService = AdministrationService();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getProducts();
      // getCategories();
    });
    super.initState();
  }

  void getProducts() async {
    setState(() {
      products = null;
    });
    final resp = await homeService.getProducts(context);
    if (!resp.error) {
      products = resp.data;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.blueGrey,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50),
      //   child: AppBarWidget(
      //     title: 'Administracion',
      //     leading: LeadingButtonWidget(keyPage: widget.keyPage),
      //   ),
      // ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 600));
              getProducts();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppTheme.blueGrey,
                  expandedHeight: 100,
                  leading: LeadingButtonWidget(
                    keyPage: widget.keyPage,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Administracion',
                      style: TextStyle(
                        color: AppTheme.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        child: FilledButtonWidget(
                          text: 'Nuevo producto',
                          onPressed: () {
                            final newProductPageKey = GlobalHelper.genKey();
                            fp.addPage(
                              key: newProductPageKey,
                              content:  NewProductPage(keyPage: newProductPageKey, key: newProductPageKey),
                            );
                            //GlobalHelper.navigateToPage(context, '/new_product');
                          },
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Nombre')),
                            DataColumn(label: Text('Precio')),
                            //DataColumn(label: Text('Marca')),
                            DataColumn(label: Text('Acciones')),
                          ],
                          rows: products?.map((e) => DataRow(cells: [
                            DataCell(Text(e.id.toString())),
                            DataCell(Text(e.name)),
                            DataCell(Text('\$${e.price}')),
                            //DataCell(Text(e.brand)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      final editProductPageKey = GlobalHelper.genKey();
                                      fp.addPage(
                                        key: editProductPageKey,
                                        content:  EditProductPage(
                                          keyPage: editProductPageKey,
                                           key: editProductPageKey,
                                           productName: e.name,
                                            productPrice: e.price.toString(),
                                            productId: e.id,
                                            productImageUrl: e.image,
                                           ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color(0xffffc107),
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      showDialog(context: context
                                      , builder: (context) => AlertDialog(
                                        title: Text('Eliminar producto'),
                                        content: Text('¿Estas seguro de eliminar el producto ${e.name}?'),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
                                          TextButton(onPressed: () async {
                                            Navigator.pop(context);
                                            final response = await administrationService.delete(context, {'id': e.id.toString()});
                                            if (!response.error) {
                                                await administrationService.delete(context, {'id': e.id.toString()});
                                                getProducts();
                                            } else {
                                      
                                            }
                                          }, child: const Text('Eliminar')),
                                        ],
                                      ));
                                      
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(0xffdc3545),
                                    )),
                              ],
                            )),
                          ])).toList() ?? [],
                        ),
                      ),
                   ],
                  )
                )
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     // Padding(
                //     //   padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                //     //   child: FilledButtonWidget(
                //     //     text: 'Nuevo producto',
                //     //     onPressed: () {
                //     //       final newProductPageKey = GlobalHelper.genKey();
                //     //       fp.addPage(
                //     //         key: newProductPageKey,
                //     //         content:  NewProductPage(keyPage: newProductPageKey, key: newProductPageKey),
                //     //       );
                //     //       //GlobalHelper.navigateToPage(context, '/new_product');
                //     //     },
                //     //   ),
                //     // ),
                //     // SingleChildScrollView(
                //     //   scrollDirection: Axis.horizontal,
                //     //   child: DataTable(
                //     //     columns: [
                //     //       DataColumn(label: Text('Nombre')),
                //     //       DataColumn(label: Text('Precio')),
                //     //       DataColumn(label: Text('Marca')),
                //     //       DataColumn(label: Text('Acciones')),
                //     //     ],
                //     //     rows: [
                //     //       DataRow(cells: [
                //     //         DataCell(Text('SAMSUNG GALAXY A54 5G 256GB')),
                //     //         DataCell(Text('\$390.36')),
                //     //         DataCell(Text('SAMSUNG')),
                //     //         DataCell(Row(
                //     //           children: [
                //     //             IconButton(
                //     //                 onPressed: () {},
                //     //                 icon: Icon(
                //     //                   Icons.edit,
                //     //                   color: Color(0xffffc107),
                //     //                 )),
                //     //             IconButton(
                //     //                 onPressed: () {},
                //     //                 icon: Icon(
                //     //                   Icons.delete,
                //     //                   color: Color(0xffdc3545),
                //     //                 )),
                //     //           ],
                //     //         )),
                //     //       ]),
                //     //       DataRow(cells: [
                //     //         DataCell(Text('IMPRESORA EPSON TINTA CONTINUA L125')),
                //     //         DataCell(Text('\$199.99')),
                //     //         DataCell(Text('EPSON')),
                //     //         DataCell(Row(
                //     //           children: [
                //     //             IconButton(
                //     //                 onPressed: () {},
                //     //                 icon: Icon(
                //     //                   Icons.edit,
                //     //                   color: Color(0xffffc107),
                //     //                 )),
                //     //             IconButton(
                //     //                 onPressed: () {},
                //     //                 icon: Icon(
                //     //                   Icons.delete,
                //     //                   color: Color(0xffdc3545),
                //     //                 )),
                //     //           ],
                //     //         )),
                //     //       ]),
                //     //       DataRow(cells: [
                //     //         DataCell(Text('Xiaomi Redmi note 11s 6+128gb')),
                //     //         DataCell(Text('\$235.99')),
                //     //         DataCell(Text('Xiaomi')),
                //     //         DataCell(Row(
                //     //           children: [
                //     //             IconButton(
                //     //                 onPressed: () {},
                //     //                 icon: Icon(
                //     //                   Icons.edit,
                //     //                   color: Color(0xffffc107),
                //     //                 )),
                //     //             IconButton(
                //     //                 onPressed: () {},
                //     //                 icon: Icon(
                //     //                   Icons.delete,
                //     //                   color: Color(0xffdc3545),
                //     //                 )),
                //     //           ],
                //     //         )),
                //     //       ]),
                //     //     ],
                //     //   ),
                //     // ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
