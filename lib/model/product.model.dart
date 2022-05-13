// To parse this JSON data, do
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<ProductModel> welcomeFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String welcomeToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    required this.quantity,
  });

  int id;
  String name;
  String category;
  double price;
  String image;
  String description;
  int quantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      price: json["price"].toDouble(),
      image: json["image"],
      description: json["description"],
      quantity: json['quantity']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "price": price,
        "image": image,
        "description": description,
        "quantity": quantity
      };
}
