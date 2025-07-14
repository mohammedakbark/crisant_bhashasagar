import 'package:bashasagar/core/models/created_at_model.dart';

class SecondaryCategoryModel {
  final String secondaryCategoryId;
  final String languageId;
  final String primaryCategoryId;
  final String secondaryCategoryName;
  final String secondaryCategoryStatus;
  final String secondaryCategoryImage;
  final String createdBy;
  final CreatedAt createdAt;
  final DateTime modifiedAt;

  SecondaryCategoryModel({
    required this.secondaryCategoryId,
    required this.languageId,
    required this.primaryCategoryId,
    required this.secondaryCategoryName,
    required this.secondaryCategoryStatus,
    required this.secondaryCategoryImage,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory SecondaryCategoryModel.fromJson(Map<String, dynamic> json) =>
      SecondaryCategoryModel(
        secondaryCategoryId: json["secondaryCategoryId"],
        languageId: json["languageId"],
        primaryCategoryId: json["primaryCategoryId"],
        secondaryCategoryName: json["secondaryCategoryName"],
        secondaryCategoryStatus: json["secondaryCategoryStatus"],
        secondaryCategoryImage: json["secondaryCategoryImage"],
        createdBy: json["createdBy"],
        createdAt: CreatedAt.fromJson(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
      );

  Map<String, dynamic> toJson() => {
    "secondaryCategoryId": secondaryCategoryId,
    "languageId": languageId,
    "primaryCategoryId": primaryCategoryId,
    "secondaryCategoryName": secondaryCategoryName,
    "secondaryCategoryStatus": secondaryCategoryStatus,
    "secondaryCategoryImage": secondaryCategoryImage,
    "createdBy": createdBy,
    "created_at": createdAt.toJson(),
    "modified_at": modifiedAt.toIso8601String(),
  };
}
