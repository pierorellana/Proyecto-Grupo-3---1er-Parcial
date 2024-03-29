
import 'package:ecommerce/env/conf/routes_api.dart';
import 'package:ecommerce/shared/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductBrandService{
  Future<List<Products>> getProductBrandId(int idBrand) async {
    final url = Uri.parse(
        '${RoutesApi.baseurl}rest/v1/productos?select=*&id_marca=eq.$idBrand');
    final response = await http.get(url, headers: RoutesApi.headers);

    if (response.statusCode == 200) {
      final products = productsFromJson(response.body);
      await Future.delayed(const Duration(milliseconds: 500));
      return products;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
