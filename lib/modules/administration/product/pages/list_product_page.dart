import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:flutter/material.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppTheme.blueGrey,
      appBar: AppBar(
        title: Text('Lista de productos'),
        backgroundColor: AppTheme.blueGrey,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            GlobalHelper.navigateToPageRemove(context, '/');
          }, icon: Icon(Icons.logout, color: Colors.black,))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: FilledButtonWidget(
                    text: 'Nuevo producto',
                    onPressed: ()  {
                        GlobalHelper.navigateToPage(context, '/new_product');
                    },
                  ),
          ),
          SingleChildScrollView(
            scrollDirection : Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Precio')),
                DataColumn(label: Text('Marca')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('SAMSUNG GALAXY A54 5G 256GB')),
                  DataCell(Text('\$390.36')),
                  DataCell(Text('SAMSUNG')),
                 DataCell(Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Color(0xffffc107),)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Color(0xffdc3545),)),
                    ],
                  )),
                ]),
                DataRow(cells: [
                  DataCell(Text('IMPRESORA EPSON TINTA CONTINUA L125')),
                  DataCell(Text('\$199.99')),
                  DataCell(Text('EPSON')),
                  DataCell(Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Color(0xffffc107),)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Color(0xffdc3545),)),
                    ],
                  )),
                ]),
                DataRow(cells: [
                  DataCell(Text('Xiaomi Redmi note 11s 6+128gb')),
                  DataCell(Text('\$235.99')),
                  DataCell(Text('Xiaomi')),
                  DataCell(Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Color(0xffffc107),)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Color(0xffdc3545),)),
                    ],
                  )),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
