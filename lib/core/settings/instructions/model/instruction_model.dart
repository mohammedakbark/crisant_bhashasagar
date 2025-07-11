import 'package:hive/hive.dart';

// part 'instruction.g.dart';

@HiveType(typeId: 0)
class Instruction extends HiveObject {
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
  DateTime createdAt;

  @HiveField(7)
  DateTime modifiedAt;

  Instruction({
    required this.instructionId,
    required this.uiLanguageId,
    required this.page,
    required this.placeholderId,
    required this.uiText,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      instructionId: json['instructionId'],
      uiLanguageId: json['uiLanguageId'],
      page: json['page'],
      placeholderId: json['placeholderId'],
      uiText: json['uiText'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['created_at']['date']),
      modifiedAt: DateTime.parse(json['modified_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'instructionId': instructionId,
        'uiLanguageId': uiLanguageId,
        'page': page,
        'placeholderId': placeholderId,
        'uiText': uiText,
        'createdBy': createdBy,
        'created_at': {'date': createdAt.toIso8601String()},
        'modified_at': modifiedAt.toIso8601String(),
      };
}
