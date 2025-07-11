import 'package:bashasagar/core/models/pagination_model.dart';

class ApiDataModel {
  final bool isError;
  final Object data;
  final PaginationModel? pagination;

  ApiDataModel({
    required this.isError,
    required this.data,
     this.pagination,
  });
}
