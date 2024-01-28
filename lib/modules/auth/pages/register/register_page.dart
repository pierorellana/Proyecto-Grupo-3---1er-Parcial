import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/auth/services/auth_service.dart';
import 'package:ecommerce/modules/auth/widgets/text_form_field_widget.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/app_bar_widget.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:ecommerce/shared/widgets/leading_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/providers/functional_provider.dart';
import '../login/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService authService = AuthService();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.blueGrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(
          title: 'Registrarse',
          leading: LeadingButtonWidget(keyPage: widget.keyPage),
        ),
      ),
      body: Center(
        child: Form(
          key: _registerFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _TextName(nameController: _nameController),
                  const SizedBox(height: 20),
                  _TextLastName(lastNameController: _lastNameController),
                  const SizedBox(height: 20),
                  _TextEmail(emailController: _emailController),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    controller: _passwordController,
                    obscureText: showPassword == false ? true : false,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(showPassword == false
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'El campo no puede estar vacío';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButtonWidget(
                      text: 'Iniciar sesión',
                      onPressed: () async {
                        final message = ScaffoldMessenger.of(context);
                        final name = _nameController.text.trim();
                        final lastname = _lastNameController.text.trim();
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();

                        final body = {
                          'name': name,
                          'last_name': lastname,
                          'email': email,
                          'password': password,
                          'phone': '1234567890',
                        };

                        if (_registerFormKey.currentState!.validate()) {
                          final response = await authService.register(context, body);
                          if(!response.error){
                            final loginPageKey = GlobalHelper.genKey();
                            fp.addPage(
                                key: loginPageKey,
                                content: LoginPage(
                                    keyPage: loginPageKey, key: loginPageKey));
                                  
                            fp.dismissAlert(key: widget.keyPage);
                            message.showSnackBar(
                              const SnackBar(
                                content: Text('¡Usuario registrado con éxito'),
                              ),
                            );
                            //GlobalHelper.navigateToPageRemove(context, '/');
                          }
                          // final success = await authService.registerCredential(
                          //     name: name,
                          //     lastname: lastname,
                          //     email: email,
                          //     password: password);

                          // if (success == 200) {
                          //   message.showSnackBar(
                          //     const SnackBar(
                          //       content: Text('¡Bienvenido a Compu Mundo!'),
                          //     ),
                          //   );

                          //   if (!mounted) return;
                          //   GlobalHelper.navigateToPageRemove(context, '/');
                          // } else if (success == 400) {
                          //   message.showSnackBar(
                          //     const SnackBar(
                          //       content: Text(
                          //           'Correo electrónico ya esta registrado'),
                          //     ),
                          //   );
                          // } else {
                          //   message.showSnackBar(
                          //     const SnackBar(
                          //       content: Text(
                          //           'Hubo un error en el servidor, intente más tarde.'),
                          //     ),
                          //   );
                          // }
                        } else {
                          GlobalHelper.showSnackBar(context,
                              'Por favor, complete todo los campos correctamente.');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextLastName extends StatelessWidget {
  const _TextLastName({
    required TextEditingController lastNameController,
  }) : _lastNameController = lastNameController;

  final TextEditingController _lastNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      hintText: 'Apellidos',
      textInputAction: TextInputAction.next,
      prefixIcon: const Icon(Icons.person),
      controller: _lastNameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo no puede estar vacío';
        }
        if (!RegExp(r'^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$').hasMatch(value)) {
          return 'El campo solo puede contener letras';
        }
        return null;
      },
    );
  }
}

class _TextName extends StatelessWidget {
  const _TextName({
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      hintText: 'Nombres',
      textInputAction: TextInputAction.next,
      prefixIcon: const Icon(Icons.person),
      controller: _nameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo no puede estar vacío';
        }
        if (!RegExp(r'^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$').hasMatch(value)) {
          return 'El campo solo puede contener letras';
        }
        return null;
      },
    );
  }
}

class _TextEmail extends StatelessWidget {
  const _TextEmail({required TextEditingController emailController})
      : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      textInputAction: TextInputAction.next,
      hintText: 'Correo electrónico',
      prefixIcon: const Icon(Icons.email),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'El campo no puede estar vacío';
        }
        if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(value)) {
          return 'El correo no es válido';
        }
        return null;
      },
    );
  }
}
