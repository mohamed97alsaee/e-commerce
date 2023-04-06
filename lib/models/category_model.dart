// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

class CategoryModel {
    CategoryModel({
       required this.nameAr,
       required this.nameEn,
    });

    String nameAr;
    String nameEn;

    factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
    );

    Map<String, dynamic> toJson() => {
        "name_ar": nameAr,
        "name_en": nameEn,
    };
}
