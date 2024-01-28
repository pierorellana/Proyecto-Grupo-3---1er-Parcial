import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/auth/widgets/text_form_field_widget.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:ecommerce/shared/widgets/leading_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../shared/providers/functional_provider.dart';
import '../../../shared/widgets/app_bar_widget.dart';
import '../services/administration_service.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key, required this.keyPage, required this.productName, required this.productPrice, required this.productId, required this.productImageUrl});
  final GlobalKey<State<StatefulWidget>> keyPage;
  final String productName;
  final String productPrice;
  final int productId;
  final String productImageUrl;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_) async {
      _nameController.text = widget.productName;
      _priceController.text = widget.productPrice;
      _controllerPhotoUrl.text = widget.productImageUrl;
    });
    super.initState();
  }

  final _newProductFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _controllerPhotoUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppTheme.blueGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(
          title: 'Editar producto',
          leading: LeadingButtonWidget(
            keyPage: widget.keyPage,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _newProductFormKey,
          child: Column(children: [
            TextFormFieldWidget(
              readOnly: true,
              hintText: 'Nombre',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.text_fields),
              controller: _nameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'El campo no puede estar vacío';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormFieldWidget(
              hintText: 'Precio',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.monetization_on),
              controller: _priceController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'El campo no puede estar vacío';
                }
                return null;
              },
            ),
            //const SizedBox(height: 20),
            // TextFormFieldWidget(
            //   hintText: 'Descripción',
            //   textInputAction: TextInputAction.next,
            //   prefixIcon: const Icon(Icons.description),
            //   controller: _descriptionController,
            //   keyboardType: TextInputType.text,
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'El campo no puede estar vacío';
            //     }
            //     return null;
            //   },
            // ),
            const SizedBox(height: 20),
            TextFormFieldWidget(
              readOnly: true,
              hintText: 'Url de la imagen',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.branding_watermark),
              controller: _controllerPhotoUrl,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'El campo no puede estar vacío';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // TextFormFieldWidget(
            //   hintText: 'Categoría',
            //   textInputAction: TextInputAction.next,
            //   prefixIcon: const Icon(Icons.category),
            //   //controller: _categoryController,
            //   keyboardType: TextInputType.text,
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'El campo no puede estar vacío';
            //     }
            //     return null;
            //   },
            // ),
            const SizedBox(height: 20),
            FilledButtonWidget(
              text: 'Editar',
              onPressed: () async {
                final administrationService = AdministrationService();
                if (_newProductFormKey.currentState!.validate()) {
                  final data = {
                    'id': widget.productId,
                    'name': _nameController.text.trim(),
                    'price': _priceController.text.trim(),
                  };
                  final response = await administrationService.update(context, data);
                  if (!response.error) {
                    fp.dismissAlert(key: widget.keyPage);
                    GlobalHelper.showSnackBar(context, 'Producto editado exitosamente');
                  }
                }
                //GlobalHelper.navigateToPageRemove(context, '/administration');
              },
            ),
          ]),
        ),
      ),
    );
  }
}
