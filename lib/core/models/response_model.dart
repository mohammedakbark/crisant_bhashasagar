import 'package:bashasagar/core/models/pagination_model.dart';

class DioResponseModel {
  int status;
  String message;
  bool error;
  Object? data;
  PaginationModel? pagination;

  DioResponseModel({
    required this.data,
    required this.error,
    required this.message,
    required this.status,
    this.pagination,
  });

  

  factory DioResponseModel.fromJson(Map<String, dynamic> json) {
    final message = json['message'];

    return DioResponseModel(
      data: json['data'],
      error: json['error'],
      message: message.toString(),
      status: json['status'],
      pagination:
          json['pagination'] != null
              ? PaginationModel.fromJson(json['pagination'])
              : null,
    );
  }
}
