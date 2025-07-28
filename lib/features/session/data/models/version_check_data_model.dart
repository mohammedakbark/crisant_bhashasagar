
class VersionCheckDataModel {
  final String secondaryCategoryId;
  final DateTime modifiedAt;

  VersionCheckDataModel({
    required this.secondaryCategoryId,
    required this.modifiedAt,
  });

  // From JSON
  factory VersionCheckDataModel.fromJson(Map<String, dynamic> json) {
    return VersionCheckDataModel(
      secondaryCategoryId: json['secondaryCategoryId'] ?? '',
      modifiedAt: DateTime.parse(json['modified_at']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'secondaryCategoryId': secondaryCategoryId,
      'modified_at': modifiedAt.toIso8601String().replaceFirst('T', ' ').split('.').first,
    };
  }
}
