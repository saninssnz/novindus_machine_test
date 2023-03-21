// To parse this JSON data, do
//
//     final newsCategoryDetailsModel = newsCategoryDetailsModelFromJson(jsonString);

import 'dart:convert';

NewsCategoryDetailsModel newsCategoryDetailsModelFromJson(String str) => NewsCategoryDetailsModel.fromJson(json.decode(str));

String newsCategoryDetailsModelToJson(NewsCategoryDetailsModel data) => json.encode(data.toJson());

class NewsCategoryDetailsModel {
  NewsCategoryDetailsModel({
    this.id,
    this.createdAt,
    this.image,
    this.title,
    this.content,
    this.category,
  });

  int? id;
  String? createdAt;
  String? image;
  String? title;
  String? content;
  int? category;

  factory NewsCategoryDetailsModel.fromJson(Map<String, dynamic> json) => NewsCategoryDetailsModel(
    id: json["id"],
    createdAt: json["created_at"],
    image: json["image"],
    title: json["title"],
    content: json["content"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "image": image,
    "title": title,
    "content": content,
    "category": category,
  };
}
