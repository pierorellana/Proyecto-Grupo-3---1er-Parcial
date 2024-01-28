import 'package:ecommerce/modules/home/models/products_response.dart';
import 'package:ecommerce/shared/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartService extends ChangeNotifier {
  final List<Products> _carProducts = [];

  List<Products> get carProducts => _carProducts;

  CartService();

  void addCartProduct(Products p) {
    bool existProduct = false;
    for (var product in _carProducts) {
      if (p.id == product.id) {
        debugPrint("el producto ya existe se aumenta la cantidad");
        product.amount++;
        existProduct = true;
      }
    }
    if (!existProduct) {
      debugPrint("el producto no existe se agrega al carrito");
      _carProducts.add(p);
    }
    notifyListeners();
  }

  void deleteProduct(Products product) {
    if (product.amount > 1) {
      for (var p in _carProducts) {
        if (p.id == product.id) {
          p.amount--;
        }
      }
    } else {
      _carProducts.remove(product);
    }
    notifyListeners();
  }

  String totalCartWithoutOffer() {
    double total = 0;
    for (var product in _carProducts) {
      if (product.offer == 0) {
        total += double.parse(product.price) * product.amount;
      }
    }
    return total.toStringAsFixed(2);
  }

  String totalCartOffer() {
    double total = 0;

    for (var product in _carProducts) {
      if (product.offer == 1) {
        total += double.parse(product.offerPrice) * product.amount;
      }
    }
    return total.toStringAsFixed(2);
  }

  String totalCart() {
    return (double.parse(totalCartWithoutOffer()) +
            double.parse(totalCartOffer()))
        .toStringAsFixed(2);
  }

  String subtotalCart() {
    return (double.parse(totalCart()) / 1.12).toStringAsFixed(2);
  }

  String ivaCart() {
    return (double.parse(totalCart()) - (double.parse(totalCart()) / 1.12))
        .toStringAsFixed(2);
  }

  int totalProductsCart() {
    int total = 0;
    for (var product in _carProducts) {
      total += product.amount;
    }
    return total;
  }

  void emptyCart() {
    _carProducts.clear();
    notifyListeners();
  }
}
