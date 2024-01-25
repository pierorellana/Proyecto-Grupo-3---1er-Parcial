import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    final int id;
    final String name;
    final String lastName;
    final String email;
    final String photo;
    final String phone;
    final int status;
    final String token;

    LoginResponse({
        required this.id,
        required this.name,
        required this.lastName,
        required this.email,
        required this.photo,
        required this.phone,
        required this.status,
        required this.token,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        photo: json["photo"],
        phone: json["phone"],
        status: json["status"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "email": email,
        "photo": photo,
        "phone": phone,
        "status": status,
        "token": token,
    };
}
