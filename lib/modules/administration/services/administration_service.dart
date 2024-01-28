import 'package:flutter/material.dart';

import '../../../shared/models/general_response.dart';
import '../../../shared/services/http_interceptor.dart';

class AdministrationService {
   InterceptorHttp interceptorHttp = InterceptorHttp();
    Future<GeneralResponse> register (BuildContext context, Map<String, String> data) async {
    try {
      String endPoint = 'product';

      GeneralResponse response = await interceptorHttp.request(context, 'POST', endPoint, data);

      return response;
    
    } catch (error) {
      debugPrint("Error en register product $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

   Future<GeneralResponse> delete (BuildContext context, Map<String, String> data) async {
    try {
      String endPoint = 'product';

      GeneralResponse response = await interceptorHttp.request(context, 'DELETE', endPoint, data);

      return response;
    
    } catch (error) {
      debugPrint("Error en eliminar produccto $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }

  Future<GeneralResponse> update (BuildContext context, Map<String, dynamic> data) async {
    try {
      String endPoint = 'product';

      GeneralResponse response = await interceptorHttp.request(context, 'PUT', endPoint, data);

      return response;
    
    } catch (error) {
      debugPrint("Error en editar produccto $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}
