import 'package:bashasagar/core/models/created_at_model.dart';

class PrimaryCategoryModel {
    final String primaryCategoryId;
    final String primaryCategoryName;
    final String languageId;
    final String primaryCategoryStatus;
    final String primaryCategoryImage;
    final String createdBy;
    final CreatedAt createdAt;
    final DateTime modifiedAt;

    PrimaryCategoryModel({
        required this.primaryCategoryId,
        required this.primaryCategoryName,
        required this.languageId,
        required this.primaryCategoryStatus,
        required this.primaryCategoryImage,
        required this.createdBy,
        required this.createdAt,
        required this.modifiedAt,
    });

    factory PrimaryCategoryModel.fromJson(Map<String, dynamic> json) => PrimaryCategoryModel(
        primaryCategoryId: json["primaryCategoryId"],
        primaryCategoryName: json["primaryCategoryName"],
        languageId: json["languageId"],
        primaryCategoryStatus: json["primaryCategoryStatus"],
        primaryCategoryImage: json["primaryCategoryImage"],
        createdBy: json["createdBy"],
        createdAt: CreatedAt.fromJson(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
    );

    Map<String, dynamic> toJson() => {
        "primaryCategoryId": primaryCategoryId,
        "primaryCategoryName": primaryCategoryName,
        "languageId": languageId,
        "primaryCategoryStatus": primaryCategoryStatus,
        "primaryCategoryImage": primaryCategoryImage,
        "createdBy": createdBy,
        "created_at": createdAt.toJson(),
        "modified_at": modifiedAt.toIso8601String(),
    };
}