import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/auth/pages/register/register_page.dart';
import 'package:ecommerce/modules/auth/services/auth_service.dart';
import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modules/administration/pages/list_product_page.dart';
import '../../modules/auth/pages/login/login_page.dart';
import '../models/login_response.dart';
import '../providers/functional_provider.dart';
import '../secure_storage/user_data_storage.dart';

class DrawerWidget extends StatefulWidget {
  static LoginResponse? userData;
  static bool isLogged = false;
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userInformation();
    });
    super.initState();
  }

  void userInformation() async {
    LoginResponse? userData = await UserDataStorage().getUserData();
    if (userData != null) {
      DrawerWidget.userData = userData;
      DrawerWidget.isLogged = true;
      //setState(() {});
    }
    // DrawerWidget.userData = userData;
    // DrawerWidget.isLogged = true;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);

    return Drawer(
      
      width: size.width * 0.78,
      elevation: 5,
      surfaceTintColor: AppTheme.blueGrey,
      backgroundColor: AppTheme.blueGrey,
      shadowColor: AppTheme.black,
      child: ListView(
        children: [
          if (DrawerWidget.isLogged)
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
                      image: NetworkImage(DrawerWidget.userData!.photo),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              accountName: Text(
                '${DrawerWidget.userData!.name} ${DrawerWidget.userData!.lastName}',
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
              accountEmail: Text(DrawerWidget.userData!.email),
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
                      'Ecormmerce',
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
                    final loginPageKey = GlobalHelper.genKey();
                    fp.addPage(
                        key: loginPageKey,
                        content: LoginPage(
                            keyPage: loginPageKey, key: loginPageKey));
                    //GlobalHelper.navigateToPage(context, '/login');
                  },
                ),
                _LisTitleDrawer(
                  title: 'Registrarse',
                  icon: Icons.app_registration_outlined,
                  onTap: () {
                    final registrePageKey = GlobalHelper.genKey();
                    Navigator.of(context).pop();
                    fp.addPage(
                        key: registrePageKey,
                        content: RegisterPage(
                            keyPage: registrePageKey, key: registrePageKey));
                    //GlobalHelper.navigateToPage(context, '/register');
                  },
                ),
              ],
            ),
          if (DrawerWidget.isLogged)
          Column(
            children: [
              _LisTitleDrawer(
              title: 'Administración',
              icon: Icons.person_outline,
              onTap: () {
                final adminPageKey = GlobalHelper.genKey();
                Navigator.of(context).pop();
                fp.addPage(
                    key: adminPageKey,
                    content: ListProductPage(
                        keyPage: adminPageKey, key: adminPageKey));
                //GlobalHelper.navigateToPage(context, '/profile');
              },
            ),
            _LisTitleDrawer(
              title: 'Cerrar sesión',
              icon: Icons.logout,
              onTap: () async {
                Navigator.of(context).pop();
                DrawerWidget.isLogged = false;
                DrawerWidget.userData = null;
                await UserDataStorage().removeUserData();
                //setState(() {});
                // showDialog(
                //   barrierDismissible: false,
                //   context: context,
                //   builder: (context) {
                //     return AlertDialogWidget(
                //       key: const Key('logout'),
                //       alertTitle: 'Cerrar Sesión',
                //       alertContent: '¿Está seguro que desea cerrar sesión?',
                //       onPressed: () async {
                //         // final message = ScaffoldMessenger.of(context);
                //         // final alert = Navigator.of(context);
                //         // final logout = await authService.logout(token);
                //         // if (logout) {
                //         //   alert.pop();
                //         //   message.showSnackBar(
                //         //     const SnackBar(
                //         //       content: Text('Sesión cerrada, vuelva pronto.'),
                //         //     ),
                //         //   );
                //         // } else {
                //         //   message.showSnackBar(
                //         //     const SnackBar(
                //         //       content: Text(
                //         //           'Error al cerrar sesión, intente de nuevo.'),
                //         //     ),
                //         //   );
                //         // }
                //       },
                //     );
                //   },
                //);
              },
            ),
            ],
          )
            
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
