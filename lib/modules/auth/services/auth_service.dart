import 'dart:convert';
import 'package:ecommerce/env/conf/routes_api.dart';
import 'package:ecommerce/shared/models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  late SharedPreferences prefs;
  void setCredentials(UserData userdata) async {
    prefs = await SharedPreferences.getInstance();
    final String token = userdata.token ?? '';
    final String name = userdata.nombreUsuario ?? '';
    final String lastname = userdata.apellidoUsuario ?? '';
    final String email = userdata.correoUsuario ?? '';
    final String photo = userdata.fotoUsuario ?? '';
    prefs.setString('token', token);
    await prefs.setString('name', name);
    await prefs.setString('lastname', lastname);
    await prefs.setString('email', email);
    await prefs.setString('photo', photo);
    await prefs.setBool('isLogged', true);
  }

  void clearCredentials() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('name');
    await prefs.remove('lastname');
    await prefs.remove('email');
    await prefs.remove('photo');
    await prefs.setBool('isLogged', false);
    prefs.clear();
  }

  Future<List> getCredentials() async {
    prefs = await SharedPreferences.getInstance();
    List credentials = [];
    final String token = prefs.getString('token') ?? '';
    final bool isLogged = prefs.getBool('isLogged') ?? false;
    final String name = prefs.getString('name') ?? '';
    final String lastname = prefs.getString('lastname') ?? '';
    final String email = prefs.getString('email') ?? '';
    final String photo = prefs.getString('photo') ?? '';

    UserData userCredentials = UserData(
      token: token,
      isLogged: isLogged,
      nombreUsuario: name,
      apellidoUsuario: lastname,
      correoUsuario: email,
      fotoUsuario: photo,
    );

    credentials.add(userCredentials);

    return credentials;
  }

  Future<int> login(String email, String password) async {
    final url =
        Uri.parse('${RoutesApi.baseurl}auth/v1/token?grant_type=password');

    final response = await http.post(url,
        headers: RoutesApi.headers,
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200) {
      final loginresponse = jsonDecode(response.body);
      final String id = loginresponse['user']['id'];
      final String token = loginresponse['access_token'];
      List<UserData> user = await getUser(id);

      for (UserData userData in user) {
        userData.token = token;
      }

      setCredentials(user.first);

      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<bool> logout(String token) async {
    final url = Uri.parse('${RoutesApi.baseurl}auth/v1/logout');
    final response = await http.post(url, headers: {
      'apikey': RoutesApi.apikey,
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 204) {
      clearCredentials();
      return true;
    }
    return false;
  }

  Future<List<UserData>> getUser(String id) async {
    final url =
        Uri.parse('${RoutesApi.baseurl}rest/v1/usuarios?id_credencial=eq.$id');
    final response = await http.get(url, headers: RoutesApi.headers);

    if (response.statusCode == 200) {
      final user = userDataFromJson(response.body);
      return user;
    }
    {
      return [];
    }
  }

  Future<int> registerCredential({
    required String email,
    required String password,
    required String name,
    required String lastname,
  }) async {
    final String photo =
        'https://ui-avatars.com/api/?name=$name+$lastname&background=000000&color=ffffff&length=2&size=200';

    final url = Uri.parse('${RoutesApi.baseurl}auth/v1/signup');

    final response = await http.post(
      url,
      headers: RoutesApi.headers,
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final loginresponse = jsonDecode(response.body);
      final String idCredential = loginresponse['user']['id'];
      final String token = loginresponse['access_token'];

      UserData userCredentials = UserData(
        token: token,
        nombreUsuario: name,
        apellidoUsuario: lastname,
        correoUsuario: email,
        fotoUsuario: photo,
      );

      setCredentials(userCredentials);

      registerUser(
        name: name,
        lastname: lastname,
        idCredential: idCredential,
        email: email,
        photo: photo,
      );

      return response.statusCode;
    }
    return response.statusCode;
  }

  Future<bool> registerUser({
    required String name,
    required String lastname,
    required String idCredential,
    required String email,
    required String photo,
  }) async {
    final url = Uri.parse('${RoutesApi.baseurl}rest/v1/usuarios');

    final response = await http.post(
      url,
      headers: RoutesApi.headersAuthorization,
      body: jsonEncode({
        "nombre_usuario": name,
        "apellido_usuario": lastname,
        "correo_usuario": email,
        "foto_usuario": photo,
        "id_credencial": idCredential
      }),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
