import 'dart:convert';
import 'package:ecommerce/shared/models/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserDataStorage {
  static AndroidOptions _getAndroidOptions() =>  const AndroidOptions(encryptedSharedPreferences: true);

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<LoginResponse?> getUserData() async {
    final data = await storage.read(key: 'userData');
    if (data != null) {
      LoginResponse response = loginResponseFromJson(data);
      return response;
    }
    return null;
  }

  // Future<DataUserModel?> getUserCredentials() async {
  //   final data = await storage.read(key: 'userCredentials');
  //   if (data != null) {
  //     DataUserModel response = dataUserModelFromJson(data);
  //     return response;
  //   }
  //   return null;
  // }

  // void setUserCredentials(DataUserModel userModel) async {
  //   final data = jsonEncode(userModel);
  //   await storage.write(key: 'userCredentials', value: data);
  // }

  void setUserData(LoginResponse userData) async {
    final data = jsonEncode(userData);
    await storage.write(key: 'userData', value: data);
  }

  removeUserData() async {
    await storage.delete(key: 'userData');
  }

  // removeUserCredentials() async {
  //   await storage.delete(key: 'userCredentials');
  // }
}
