import 'package:bashasagar/features/settings/data/models/ui_created_at.dart';
import 'package:hive/hive.dart';

part 'ui_instruction_model.g.dart';

@HiveType(typeId: 0)
class UiInstructionModel extends HiveObject {
  @HiveField(0)
  String instructionId;

  @HiveField(1)
  String uiLanguageId;

  @HiveField(2)
  String page;

  @HiveField(3)
  String placeholderId;

  @HiveField(4)
  String uiText;

  @HiveField(5)
  String createdBy;

  @HiveField(6)
  UiLangCreatedAt createdAt;

  @HiveField(7)
  DateTime modifiedAt;

  UiInstructionModel({
    required this.instructionId,
    required this.uiLanguageId,
    required this.page,
    required this.placeholderId,
    required this.uiText,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory UiInstructionModel.fromJson(Map<String, dynamic> json) => UiInstructionModel(
        instructionId: json["instructionId"],
        uiLanguageId: json["uiLanguageId"],
        page: json["page"],
        placeholderId: json["placeholderId"],
        uiText: json["uiText"],
        createdBy: json["createdBy"],
        createdAt: UiLangCreatedAt.fromJson(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
      );

  Map<String, dynamic> toJson() => {
        "instructionId": instructionId,
        "uiLanguageId": uiLanguageId,
        "page": page,
        "placeholderId": placeholderId,
        "uiText": uiText,
        "createdBy": createdBy,
        "created_at": createdAt.toJson(),
        "modified_at": modifiedAt.toIso8601String(),
      };
}
