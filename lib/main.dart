import 'package:ecommerce/env/environment.dart';
import 'package:ecommerce/env/theme/app_theme.dart';
import 'package:ecommerce/modules/cart/services/cart_service.dart';
import 'package:ecommerce/shared/providers/functional_provider.dart';
import 'package:ecommerce/shared/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  String environment = const String.fromEnvironment('ENVIRONMENT', defaultValue: Environment.dev);
  Environment().initConfig(environment);
  //initializeDateFormatting('es');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartService(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (_) => FunctionalProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppTheme.blueDark,
          ),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
