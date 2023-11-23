import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/auth/widgets/text_form_field_widget.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:flutter/material.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blueGrey,
      appBar: AppBar(
        title: Text('Nuevo producto'),
        backgroundColor: AppTheme.blueGrey,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          child: Column(children: [
            TextFormFieldWidget(
              hintText: 'Nombre',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.text_fields),
              //controller: _nameController,
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
              //controller: _priceController,
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
              //controller: _descriptionController,
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
              hintText: 'Marca',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.branding_watermark),
              //controller: _brandController,
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
              hintText: 'Categoría',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.category),
              //controller: _categoryController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'El campo no puede estar vacío';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FilledButtonWidget(
              text: 'Guardar',
              onPressed: () {
                GlobalHelper.navigateToPageRemove(context, '/administration');
              },
            ),
          ]),
        ),
      ),
    );
  }
}
