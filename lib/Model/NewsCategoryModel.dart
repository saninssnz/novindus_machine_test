// To parse this JSON data, do
//
//     final newsCategoryModel = newsCategoryModelFromJson(jsonString);

import 'dart:convert';

NewsCategoryModel newsCategoryModelFromJson(String str) => NewsCategoryModel.fromJson(json.decode(str));

String newsCategoryModelToJson(NewsCategoryModel data) => json.encode(data.toJson());

class NewsCategoryModel {
  NewsCategoryModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) => NewsCategoryModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
