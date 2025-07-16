part of 'content_controller_bloc.dart';

@immutable
sealed class ContentControllerEvent {}

class DownloadContentById extends ContentControllerEvent {
  final String primaryCategoryId;
  final String secondaryCategoryId;
  DownloadContentById({
    required this.primaryCategoryId,
    required this.secondaryCategoryId,
  });
}

class DeleteContentById extends ContentControllerEvent {
  final String primaryCategoryId;

  final String secondaryCategoryId;
  DeleteContentById({
    required this.secondaryCategoryId,
    required this.primaryCategoryId,
  });
}

