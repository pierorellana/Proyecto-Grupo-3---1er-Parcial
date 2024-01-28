import 'dart:convert';

import 'package:ecommerce/modules/home/models/category_response.dart';
import 'package:ecommerce/modules/home/models/products_response.dart';
import 'package:ecommerce/shared/models/general_response.dart';
import 'package:ecommerce/shared/services/http_interceptor.dart';
import 'package:flutter/material.dart';

class HomeService {
  InterceptorHttp interceptorHttp = InterceptorHttp();

   Future<GeneralResponse<List<Products>>> getProducts(BuildContext context,{Map<String, dynamic>? queryParameters}) async {

    try {
      String endPoint = 'product';

      GeneralResponse response = await interceptorHttp.request(context, 'GET', endPoint, null, queryParameters: null);

      List<Products>? products;

      if (!response.error) {
        products = productsFromJson(jsonEncode(response.data));
      }

      return GeneralResponse(data: products, message: response.message, error: response.error);
    } catch (error) {
      debugPrint("Error en productos $error");
      return GeneralResponse(message: error.toString(), error: true);
    }

  }

  Future<GeneralResponse<CategoryResponse>> getCategories(BuildContext context) async {
    try {
      String endPoint = 'category';

      GeneralResponse response = await interceptorHttp.request(context, 'GET', endPoint, null, showLoading: false);

      late CategoryResponse categoryResponse;
      //late DataUserModel userCredentials;

      if (!response.error) {
        categoryResponse = categoryResponseFromJson(jsonEncode(response.data));
      }

      return GeneralResponse(
          data: categoryResponse, message: response.message, error: response.error);
    } catch (error) {
        debugPrint("Error en categorias $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}
