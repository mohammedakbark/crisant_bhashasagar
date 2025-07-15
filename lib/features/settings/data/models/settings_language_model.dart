import 'package:bashasagar/core/models/created_at_model.dart';

class SettingsLanguageModel {
  final String languageId;
  final String languageCode;
  final String languageName;
  final String languageImageLight;
  final String lanuageImageDark;
  final CreatedAt createdAt;
  final DateTime modifiedAt;
  final String selected;

  SettingsLanguageModel({
    required this.languageId,
    required this.languageCode,
    required this.languageName,
    required this.languageImageLight,
    required this.lanuageImageDark,
    required this.createdAt,
    required this.modifiedAt,
    required this.selected,
  });

  factory SettingsLanguageModel.fromJson(Map<String, dynamic> json) =>
      SettingsLanguageModel(
        languageId: json["languageId"],
        languageCode: json["languageCode"],
        languageName: json["languageName"],
        languageImageLight: json["languageImageLight"],
        lanuageImageDark: json["lanuageImageDark"],
        createdAt: CreatedAt.fromJson(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        selected: json["selected"],
      );

  Map<String, dynamic> toJson() => {
    "languageId": languageId,
    "languageCode": languageCode,
    "languageName": languageName,
    "languageImageLight": languageImageLight,
    "lanuageImageDark": lanuageImageDark,
    "created_at": createdAt.toJson(),
    "modified_at": modifiedAt.toIso8601String(),
    "selected": selected,
  };
}
