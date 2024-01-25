
import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/auth/services/auth_service.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  AuthService authService = AuthService();
  String token = '';
  String name = 'nombre';
  String lastname = 'apellido';
  String email = 'correo electrónico';
  String photo = '';
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    //getData();
  }

  // void getData() async {
  //   final user = await authService.getCredentials();
  //   setState(() {
  //     token = user[0].token;
  //     name = user[0].nombreUsuario;
  //     lastname = user[0].apellidoUsuario;
  //     email = user[0].correoUsuario;
  //     photo = user[0].fotoUsuario;
  //     isLogged = user[0].isLogged;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.845,
      elevation: 5,
      surfaceTintColor: AppTheme.blueGrey,
      backgroundColor: AppTheme.blueGrey,
      shadowColor: AppTheme.black,
      child: ListView(
        children: [
          if (isLogged)
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppTheme.blueGrey,
                    AppTheme.blueDark,
                  ],
                ),
              ),
              currentAccountPicture: CircleAvatar(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage(
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Image(
                            image: AssetImage('assets/no-image.png'));
                      },
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(photo),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              accountName: Text(
                '$name $lastname',
                style: TextStyle(
                  shadows: [
                    BoxShadow(
                      color: AppTheme.black.withOpacity(0.4),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
              accountEmail: Text(email),
            )
          else
            Column(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppTheme.blueGrey,
                        AppTheme.blueDark,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Compu Mundo',
                      style: TextStyle(
                        shadows: [
                          BoxShadow(
                            color: AppTheme.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.066,
                      ),
                    ),
                  ),
                ),
                _LisTitleDrawer(
                  title: 'Home',
                  icon: Icons.home_outlined,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                _LisTitleDrawer(
                  title: 'Iniciar sesión',
                  icon: Icons.login,
                  onTap: () {
                    Navigator.of(context).pop();
                    GlobalHelper.navigateToPage(context, '/login');
                  },
                ),
                _LisTitleDrawer(
                  title: 'Registrarse',
                  icon: Icons.app_registration_outlined,
                  onTap: () {
                    Navigator.of(context).pop();
                    GlobalHelper.navigateToPage(context, '/register');
                  },
                ),
              ],
            ),
          if (isLogged)
            _LisTitleDrawer(
              title: 'Cerrar sesión',
              icon: Icons.logout,
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      key: const Key('logout'),
                      alertTitle: 'Cerrar Sesión',
                      alertContent: '¿Está seguro que desea cerrar sesión?',
                      onPressed: () async {
                        // final message = ScaffoldMessenger.of(context);
                        // final alert = Navigator.of(context);
                        // final logout = await authService.logout(token);
                        // if (logout) {
                        //   alert.pop();
                        //   message.showSnackBar(
                        //     const SnackBar(
                        //       content: Text('Sesión cerrada, vuelva pronto.'),
                        //     ),
                        //   );
                        // } else {
                        //   message.showSnackBar(
                        //     const SnackBar(
                        //       content: Text(
                        //           'Error al cerrar sesión, intente de nuevo.'),
                        //     ),
                        //   );
                        // }
                      },
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _LisTitleDrawer extends StatelessWidget {
  const _LisTitleDrawer({
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppTheme.white,
      color: AppTheme.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppTheme.borderGrey, width: 0.20),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Icon(icon, color: AppTheme.black),
        title: Text(title, style: const TextStyle(color: AppTheme.black)),
        onTap: onTap,
      ),
    );
  }
}
