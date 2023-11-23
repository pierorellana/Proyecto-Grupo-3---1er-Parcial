import 'dart:convert';

List<Brands> brandsFromJson(String str) =>
    List<Brands>.from(json.decode(str).map((x) => Brands.fromJson(x)));

String brandsToJson(List<Brands> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Brands {
  final int id;
  final String nombre;
  final String imagen;
  final DateTime createdAt;

  Brands({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.createdAt,
  });

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
