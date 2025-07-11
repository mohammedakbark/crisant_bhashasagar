import 'package:bashasagar/core/models/created_at_model.dart';

class ProfileModel {
  int iat;
  int nbf;
  Userinfo userinfo;

  ProfileModel({required this.iat, required this.nbf, required this.userinfo});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    iat: json["iat"],
    nbf: json["nbf"],
    userinfo: Userinfo.fromJson(json["userinfo"]),
  );

  Map<String, dynamic> toJson() => {
    "iat": iat,
    "nbf": nbf,
    "userinfo": userinfo.toJson(),
  };
}

class Userinfo {
  String customerId;
  String customerName;
  String customerMobile;
  String customerEmailAddress;
  String customerAddress;
  String customerGender;
  String customerAge;
  String customerOtp;
  String customerStatus;
  CreatedAt createdAt;
  DateTime modifiedAt;

  Userinfo({
    required this.customerId,
    required this.customerName,
    required this.customerMobile,
    required this.customerEmailAddress,
    required this.customerAddress,
    required this.customerGender,
    required this.customerAge,
    required this.customerOtp,
    required this.customerStatus,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
    customerId: json["customerId"] ?? "N/A",
    customerName: json["customerName"] ?? "N/A",
    customerMobile: json["customerMobile"] ?? "N/A",
    customerEmailAddress: json["customerEmailAddress"] ?? "N/A",
    customerAddress: json["customerAddress"] ?? "N/A",
    customerGender: json["customerGender"] ?? "N/A",
    customerAge: json["customerAge"] ?? "N/A",
    customerOtp: json["customerOTP"] ?? "N/A",
    customerStatus: json["customerStatus"] ?? "N/A",
    createdAt: CreatedAt.fromJson(json["created_at"]),
    modifiedAt: DateTime.parse(json["modified_at"]),
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "customerName": customerName,
    "customerMobile": customerMobile,
    "customerEmailAddress": customerEmailAddress,
    "customerAddress": customerAddress,
    "customerGender": customerGender,
    "customerAge": customerAge,
    "customerOTP": customerOtp,
    "customerStatus": customerStatus,
    "created_at": createdAt.toJson(),
    "modified_at": modifiedAt.toIso8601String(),
  };
}
