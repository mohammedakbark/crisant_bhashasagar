import 'package:bashasagar/core/models/created_at_model.dart';

class SearchWordModel {
  final String contentAlias;
  final String content;
  final String contentMediaType;
  final String contentMedia;
  final String contentAudio;
  final CreatedAt createdAt;
  final DateTime modifiedAt;
  final String textInUiLanguage;

  SearchWordModel({
    required this.contentAlias,
    required this.content,
    required this.contentMediaType,
    required this.contentMedia,
    required this.contentAudio,
    required this.createdAt,
    required this.modifiedAt,
    required this.textInUiLanguage,
  });

  factory SearchWordModel.fromJson(Map<String, dynamic> json) =>
      SearchWordModel(
        contentAlias: json["contentAlias"] ?? '',
        content: json["content"] ?? '',
        contentMediaType: json["contentMediaType"] ?? '',
        contentMedia: json["contentMedia"] ?? '',
        contentAudio: json["contentAudio"] ?? '',
        createdAt: CreatedAt.fromJson(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        textInUiLanguage: json["textInUILanguage"]??'',
      );

  Map<String, dynamic> toJson() => {
    "contentAlias": contentAlias,
    "content": content,
    "contentMediaType": contentMediaType,
    "contentMedia": contentMedia,
    "contentAudio": contentAudio,
    "created_at": createdAt.toJson(),
    "modified_at": modifiedAt.toIso8601String(),
    "textInUILanguage": textInUiLanguage,
  };
}
