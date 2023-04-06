// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

class ProductModel {
  ProductModel({
    required this.categoryUid,
    required this.imageUrl,
    required this.nameAr,
    required this.nameEn,
    required this.price,
  });

  String categoryUid;
  String imageUrl;
  String nameAr;
  String nameEn;
  String price;

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        categoryUid: json["category_uid"],
        imageUrl: json["image_url"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "category_uid": categoryUid,
        "image_url": imageUrl,
        "name_ar": nameAr,
        "name_en": nameEn,
        "price": price,
      };
}
