import 'package:hive/hive.dart';

part 'ui_created_at.g.dart';

@HiveType(typeId: 1)
class UiLangCreatedAt {
  @HiveField(0)
  String date;

  @HiveField(1)
  int timezoneType;

  @HiveField(2)
  String timezone;

  UiLangCreatedAt({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory UiLangCreatedAt.fromJson(Map<String, dynamic> json) => UiLangCreatedAt(
        date: json["date"],
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}
