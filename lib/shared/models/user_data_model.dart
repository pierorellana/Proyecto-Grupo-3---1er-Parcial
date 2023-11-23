import 'dart:convert';

List<UserData> userDataFromJson(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserData {
  int? id;
  String? token;
  String? nombreUsuario;
  String? apellidoUsuario;
  String? correoUsuario;
  String? fotoUsuario;
  String? idCredencial;
  bool? isLogged;

  UserData({
    this.id,
    this.token,
    this.nombreUsuario,
    this.apellidoUsuario,
    this.correoUsuario,
    this.fotoUsuario,
    this.idCredencial,
    this.isLogged,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        nombreUsuario: json["nombre_usuario"],
        apellidoUsuario: json["apellido_usuario"],
        correoUsuario: json["correo_usuario"],
        fotoUsuario: json["foto_usuario"],
        idCredencial: json["id_credencial"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_usuario": nombreUsuario,
        "apellido_usuario": apellidoUsuario,
        "correo_usuario": correoUsuario,
        "foto_usuario": fotoUsuario,
        "id_credencial": idCredencial,
      };
}
