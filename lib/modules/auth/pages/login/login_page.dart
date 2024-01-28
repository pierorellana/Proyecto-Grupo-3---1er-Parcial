import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/auth/pages/register/register_page.dart';
import 'package:ecommerce/modules/auth/services/auth_service.dart';
import 'package:ecommerce/modules/auth/widgets/text_form_field_widget.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/alert_modal.dart';
import 'package:ecommerce/shared/widgets/app_bar_widget.dart';
import 'package:ecommerce/shared/widgets/filled_button_widget.dart';
import 'package:ecommerce/shared/widgets/leading_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/providers/functional_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.keyPage});
  final GlobalKey<State<StatefulWidget>> keyPage;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.blueGrey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(
          title: 'Iniciar sesión',
          leading: LeadingButtonWidget(
            keyPage: widget.keyPage,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormFieldWidget(
                    hintText: 'Correo electrónico',
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.email),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'El campo no puede estar vacío';
                      }
                      if (!RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(value)) {
                        return 'El correo no es válido';
                      }
                      return null;
                    },
                  ),
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
                  const _ForgotPassword(),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButtonWidget(
                      text: 'Iniciar sesión',
                      onPressed: () async {
                        //final message = ScaffoldMessenger.of(context);
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        final data = {'email': email, 'password': password};

                        if (_loginFormKey.currentState!.validate()) {
                          final response = await authService.login(context, data);

                          if (response) {
                            fp.dismissAlert(key: widget.keyPage);
                          }
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
                          //       content: Text('Correo o contraseña incorrectos.'),
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
                  const SizedBox(height: 5),
                  const _CreateAccount(),
                  // TextButton(
                  //   onPressed: () {
                  //     GlobalHelper.navigateToPageRemove(
                  //         context, '/administration');
                  //   },
                  //   child: const Text(
                  //     'Administración',
                  //     style: TextStyle(
                  //       color: AppTheme.black,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateAccount extends StatelessWidget {
  const _CreateAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            final registrePageKey = GlobalHelper.genKey();
            final fp = Provider.of<FunctionalProvider>(context, listen: false);
                    fp.addPage(
                        key: registrePageKey,
                        content: RegisterPage(
                            keyPage: registrePageKey, key: registrePageKey));
            // GlobalHelper.navigateToPage(context, '/register');
          },
          child: const Text(
            'Crear una cuenta',
            style: TextStyle(
              color: AppTheme.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            '¿Necesitas ayuda?',
            style: TextStyle(
              color: AppTheme.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(
              color: AppTheme.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
