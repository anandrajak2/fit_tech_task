// To parse this JSON data, do
//
//     final dogImageModel = dogImageModelFromJson(jsonString);

import 'dart:convert';

DogImageModel dogImageModelFromJson(String str) =>
    DogImageModel.fromJson(json.decode(str));

String dogImageModelToJson(DogImageModel data) => json.encode(data.toJson());

class DogImageModel {
  final String message;
  final String status;

  DogImageModel({
    required this.message,
    required this.status,
  });

  factory DogImageModel.fromJson(Map<String, dynamic> json) => DogImageModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
