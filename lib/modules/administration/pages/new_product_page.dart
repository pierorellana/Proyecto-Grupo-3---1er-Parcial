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

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _newProductFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _controllerPhotoUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppTheme.blueGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(
          title: 'Nuevo producto',
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
            const SizedBox(height: 20),
            TextFormFieldWidget(
              hintText: 'Descripción',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.description),
              controller: _descriptionController,
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
              text: 'Guardar',
              onPressed: () async {
                final administrationService = AdministrationService();
                if (_newProductFormKey.currentState!.validate()) {
                  final data = {
                    'name': _nameController.text.trim(),
                    'price': _priceController.text.trim(),
                    'description': _descriptionController.text.trim(),
                    'image_url': _controllerPhotoUrl.text.trim(),
                  };
                  final response = await administrationService.register(context, data);
                  if (!response.error) {
                    fp.dismissAlert(key: widget.keyPage);
                    GlobalHelper.showSnackBar(context, 'Producto registrado exitosamente');
              
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
