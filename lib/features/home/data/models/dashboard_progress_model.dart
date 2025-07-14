class DashboardLanguageProgressModel {
    final String languageId;
    final Details details;
    final Status status;

    DashboardLanguageProgressModel({
        required this.languageId,
        required this.details,
        required this.status,
    });

    factory DashboardLanguageProgressModel.fromJson(Map<String, dynamic> json) => DashboardLanguageProgressModel(
        languageId: json["languageId"],
        details: Details.fromJson(json["details"]),
        status: Status.fromJson(json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "languageId": languageId,
        "details": details.toJson(),
        "status": status.toJson(),
    };
}

class Details {
    final String languageCode;
    final String languageName;
    final String languageImageLight;
    final String lanuageImageDark;

    Details({
        required this.languageCode,
        required this.languageName,
        required this.languageImageLight,
        required this.lanuageImageDark,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        languageCode: json["languageCode"],
        languageName: json["languageName"],
        languageImageLight: json["languageImageLight"],
        lanuageImageDark: json["lanuageImageDark"],
    );

    Map<String, dynamic> toJson() => {
        "languageCode": languageCode,
        "languageName": languageName,
        "languageImageLight": languageImageLight,
        "lanuageImageDark": lanuageImageDark,
    };
}

class Status {
    final int totalPrimaryCategories;
    final int totalSecondaryCategories;
    final int totalCompleted;
    final int percentage;

    Status({
        required this.totalPrimaryCategories,
        required this.totalSecondaryCategories,
        required this.totalCompleted,
        required this.percentage,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        totalPrimaryCategories: json["totalPrimaryCategories"],
        totalSecondaryCategories: json["totalSecondaryCategories"],
        totalCompleted: json["totalCompleted"],
        percentage: json["percentage"],
    );

    Map<String, dynamic> toJson() => {
        "totalPrimaryCategories": totalPrimaryCategories,
        "totalSecondaryCategories": totalSecondaryCategories,
        "totalCompleted": totalCompleted,
        "percentage": percentage,
    };
}
