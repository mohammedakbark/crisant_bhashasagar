import 'package:bashasagar/core/models/created_at_model.dart';

class UiLangModel {
    String uiLanguageId;
    String uiLanguageCode;
    String uiLanguageName;
    String uiImageLight;
    String uiImageDark;
    String uiLanguageStatus;
    String createdBy;
    CreatedAt createdAt;
    DateTime modifiedAt;

    UiLangModel({
        required this.uiLanguageId,
        required this.uiLanguageCode,
        required this.uiLanguageName,
        required this.uiImageLight,
        required this.uiImageDark,
        required this.uiLanguageStatus,
        required this.createdBy,
        required this.createdAt,
        required this.modifiedAt,
    });

    factory UiLangModel.fromJson(Map<String, dynamic> json) => UiLangModel(
        uiLanguageId: json["uiLanguageId"]??'',
        uiLanguageCode: json["uiLanguageCode"]??'',
        uiLanguageName: json["uiLanguageName"]??'',
        uiImageLight: json["uiImageLight"]??'',
        uiImageDark: json["uiImageDark"]??'',
        uiLanguageStatus: json["uiLanguageStatus"]??'',
        createdBy: json["createdBy"]??'',
        createdAt: CreatedAt.fromJson(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
    );

    Map<String, dynamic> toJson() => {
        "uiLanguageId": uiLanguageId,
        "uiLanguageCode": uiLanguageCode,
        "uiLanguageName": uiLanguageName,
        "uiImageLight": uiImageLight,
        "uiImageDark": uiImageDark,
        "uiLanguageStatus": uiLanguageStatus,
        "createdBy": createdBy,
        "created_at": createdAt.toJson(),
        "modified_at": modifiedAt.toIso8601String(),
    };
}