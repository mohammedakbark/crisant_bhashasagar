import 'package:bashasagar/core/models/created_at_model.dart';

class ContentJsonModel {
  final String contentId;
  final String contentAlias;
  final String languageId;
  final String primaryCategoryId;
  final String secondaryCategoryId;
  final String content;
  final String contentMediaType;
  final String contentMedia;
  final String contentAudio;
  final String contentStatus;
  final String createdBy;
  final CreatedAt createdAt;
  final DateTime modifiedAt;
  final String? originalText;

  ContentJsonModel({
    required this.contentId,
    required this.contentAlias,
    required this.languageId,
    required this.primaryCategoryId,
    required this.secondaryCategoryId,
    required this.content,
    required this.contentMediaType,
    required this.contentMedia,
    required this.contentAudio,
    required this.contentStatus,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedAt,
    required this.originalText,
  });

  factory ContentJsonModel.fromJson(Map<String, dynamic> json) =>
      ContentJsonModel(
        originalText: json['originalText'],
        contentId: json["contentId"],
        contentAlias: json["contentAlias"],
        languageId: json["languageId"],
        primaryCategoryId: json["primaryCategoryId"],
        secondaryCategoryId: json["secondaryCategoryId"],
        content: json["content"],
        contentMediaType: json["contentMediaType"],
        contentMedia: json["contentMedia"],
        contentAudio: json["contentAudio"],
        contentStatus: json["contentStatus"],
        createdBy: json["createdBy"],
        createdAt: CreatedAt.fromJson(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
      );

  Map<String, dynamic> toJson() => {
    "originalText": originalText,
    "contentId": contentId,
    "contentAlias": contentAlias,
    "languageId": languageId,
    "primaryCategoryId": primaryCategoryId,
    "secondaryCategoryId": secondaryCategoryId,
    "content": content,
    "contentMediaType": contentMediaType,
    "contentMedia": contentMedia,
    "contentAudio": contentAudio,
    "contentStatus": contentStatus,
    "createdBy": createdBy,
    "created_at": createdAt.toJson(),
    "modified_at": modifiedAt.toIso8601String(),
  };
}
