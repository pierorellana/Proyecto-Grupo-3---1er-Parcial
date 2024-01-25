import 'dart:convert';

import 'package:ecommerce/shared/helpers/global_helper.dart';
import 'package:ecommerce/shared/models/general_response.dart';
import 'package:ecommerce/shared/models/login_response.dart';
import 'package:ecommerce/shared/secure_storage/user_data_storage.dart';
import 'package:ecommerce/shared/services/http_interceptor.dart';
import 'package:flutter/material.dart';

class AuthService {
  InterceptorHttp interceptorHttp = InterceptorHttp();

 Future login (BuildContext context, Map<String, String> data) async {
    try {

      String endPoint = 'auth/login';

      GeneralResponse response = await interceptorHttp.request(context, 'POST', endPoint, data);

      late LoginResponse userData;
      //late DataUserModel userCredentials;
      
      if (!response.error) {
        userData = loginResponseFromJson(jsonEncode(response.data));
        UserDataStorage().setUserData(userData);
        if (context.mounted) GlobalHelper.navigateToPageRemove(context, '/home');
        //userCredentials = dataUserModelFromJson(jsonEncode(data));

        // if(userData.cambiarClave){
        //   UserDataStorage().setUserCredentials(userCredentials);
        //   if (context.mounted) GlobalHelper.navigateToPageRemove(context, '/change_password');
        // }else{
        //   UserDataStorage().setUserData(userData);
        //   //await Future.delayed(const Duration(milliseconds: 150));
        //   if (context.mounted) GlobalHelper.navigateToPageRemove(context, '/home');
        // }
      }
    }catch(error){
      debugPrint("Error en Login $error");
      return GeneralResponse(message: error.toString(), error: true);
    }
    
  }
}
