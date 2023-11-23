import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  final int id;
  final String name;
  final String image;
  final String price;
  final int status;
  final String offerPrice;
  final int offer;
  final String discountLabel;
  final int wantedProduct;
  final int brandId;
  final int categoryId;
  final DateTime creationDate;
  int amount;

  Products({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.status,
    required this.offerPrice,
    required this.offer,
    required this.discountLabel,
    required this.wantedProduct,
    required this.brandId,
    required this.categoryId,
    required this.creationDate,
    this.amount = 1
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        status: json["status"],
        offerPrice: json["offer_price"],
        offer: json["offer"],
        discountLabel: json["discount_label"],
        wantedProduct: json["wanted_product"],
        brandId: json["brand_id"],
        categoryId: json["category_id"],
        creationDate: DateTime.parse(json["creation_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "status": status,
        "offer_price": offerPrice,
        "offer": offer,
        "discount_label": discountLabel,
        "wanted_product": wantedProduct,
        "brand_id": brandId,
        "category_id": categoryId,
        "creation_date": creationDate.toIso8601String(),
      };
}
