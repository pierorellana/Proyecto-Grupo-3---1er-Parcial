import 'package:ecommerce/env/conf/routes_api.dart';
import 'package:ecommerce/shared/models/brands_model.dart';
import 'package:ecommerce/shared/models/category_model.dart';
import 'package:ecommerce/shared/models/product_model.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<Brands>> getBrands() async {
    final url = Uri.parse('${RoutesApi.baseurl}rest/v1/marcas');
    final response = await http.get(url, headers: RoutesApi.headers);

    if (response.statusCode == 200) {
      final brands = brandsFromJson(response.body);
      return brands;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  Future<List<Products>> getProducts() async {
    final url = Uri.parse('${RoutesApi.baseurl}product');
    final response = await http.get(url, headers: RoutesApi.headers);

    if (response.statusCode == 200) {
      final products = productsFromJson(response.body);

      return products;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  Future<List<Category>> getCategories() async {
    final url = Uri.parse('${RoutesApi.baseurl}rest/v1/categorias');
    final response = await http.get(url, headers: RoutesApi.headers);

    if (response.statusCode == 200) {
      final categories = categoryFromJson(response.body);

      return categories;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  Future<List<Products>> getProductsOffer() async {
    final url =
        Uri.parse('${RoutesApi.baseurl}product?offer=1');
    final response = await http.get(url, headers: RoutesApi.headers);

    if (response.statusCode == 200) {
      final products = productsFromJson(response.body);

      return products;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }

  Future<List<Products>> wantedProducts() async {
    final url =
        Uri.parse('${RoutesApi.baseurl}product?wanted_product=1');
    final response = await http.get(url, headers: RoutesApi.headers);

    if (response.statusCode == 200) {
      final products = productsFromJson(response.body);

      return products;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }//wanted products
}
