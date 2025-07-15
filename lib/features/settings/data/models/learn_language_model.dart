// import 'package:bashasagar/core/models/created_at_model.dart';

// class LearnLanguageModel {
//   final String languageId;
//   final String languageCode;
//   final String languageName;
//   final String languageImageLight;
//   final String lanuageImageDark;
//   final String createdBy;
//   final CreatedAt createdAt;
//   final DateTime modifiedAt;

//   LearnLanguageModel({
//     required this.languageId,
//     required this.languageCode,
//     required this.languageName,
//     required this.languageImageLight,
//     required this.lanuageImageDark,
//     required this.createdBy,
//     required this.createdAt,
//     required this.modifiedAt,
//   });

//   factory LearnLanguageModel.fromJson(Map<String, dynamic> json) =>
//       LearnLanguageModel(
//         languageId: json["languageId"],
//         languageCode: json["languageCode"],
//         languageName: json["languageName"],
//         languageImageLight: json["languageImageLight"],
//         lanuageImageDark: json["lanuageImageDark"],
//         createdBy: json["createdBy"],
//         createdAt: CreatedAt.fromJson(json["created_at"]),
//         modifiedAt: DateTime.parse(json["modified_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//     "languageId": languageId,
//     "languageCode": languageCode,
//     "languageName": languageName,
//     "languageImageLight": languageImageLight,
//     "lanuageImageDark": lanuageImageDark,
//     "createdBy": createdBy,
//     "created_at": createdAt.toJson(),
//     "modified_at": modifiedAt.toIso8601String(),
//   };
// }
