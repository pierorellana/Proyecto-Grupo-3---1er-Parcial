import 'package:ecommerce/modules/404/pages/not_found_page.dart';
import 'package:ecommerce/modules/administration/product/pages/list_product_page.dart';
import 'package:ecommerce/modules/administration/product/pages/new_product_page.dart';
import 'package:ecommerce/modules/auth/pages/login/login_page.dart';
import 'package:ecommerce/modules/auth/pages/register/register_page.dart';
import 'package:ecommerce/modules/cart/pages/cart_page.dart';
import 'package:ecommerce/modules/home/pages/home_page.dart';
import 'package:ecommerce/modules/product_brand/pages/product_brand_page.dart';
import 'package:ecommerce/modules/product_category/pages/product_category_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initialRoute = '/login';

  static final Map<String, WidgetBuilder> routes = {
    '/home': (_) => const HomePage(),
    // '/product_brand': (_) => const ProductBrandPage(),
    // '/product_category': (_) => const ProductCategoryPage(),
    '/login': (_) => const LoginPage(),
    //'/cart': (_) => const CartPage(),
    //'/register': (_) => const RegisterPage(),
    '/administration': (_) => const ListProductPage(),
    '/new_product': (_) => const NewProductPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder: (_) => const PageNotFound(),
        );
    }
  }
}
