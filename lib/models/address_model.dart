// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

class AddressModel {
  AddressModel({
    required this.id,
    required this.name,
    this.description,
    required this.long,
    required this.lat,
  });

  int id;
  String name;
  String? description;
  String long;
  String lat;

  factory AddressModel.fromRawJson(String str) =>
      AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        long: json["long"],
        lat: json["lat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "long": long,
        "lat": lat,
      };
}
