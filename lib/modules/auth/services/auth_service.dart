import 'dart:convert';

import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/models/general_response.dart';
import 'package:ecommerce/shared/models/login_response.dart';
import 'package:ecommerce/shared/secure_storage/user_data_storage.dart';
import 'package:ecommerce/shared/services/http_interceptor.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/drawer_widget.dart';

class AuthService {
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future<bool> login(BuildContext context, Map<String, String> data) async {
    try {
      String endPoint = 'auth/login';

      GeneralResponse response =
          await interceptorHttp.request(context, 'POST', endPoint, data);

      late LoginResponse userData;
      //late DataUserModel userCredentials;

      if (!response.error) {
        userData = loginResponseFromJson(jsonEncode(response.data));
        UserDataStorage().setUserData(userData);
        DrawerWidget.userData = userData;
        DrawerWidget.isLogged = true;
        return true;
      } else {
        return false;
      }
    
    } catch (error) {
      debugPrint("Error en Login $error");
      return false;
    }
  }
  Future<GeneralResponse> register (BuildContext context, Map<String, String> data) async {
    try {
      String endPoint = 'auth/register';

      GeneralResponse response = await interceptorHttp.request(context, 'POST', endPoint, data);

      return response;
    
    } catch (error) {
      debugPrint("Error en Login $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
  }
}
