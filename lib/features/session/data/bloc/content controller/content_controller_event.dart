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

class LoadContentById extends ContentControllerEvent {
  final String primaryCategoryId;

  final String secondaryCategoryId;
  LoadContentById({
    required this.secondaryCategoryId,
    required this.primaryCategoryId,
  });
}

class OnChangeContent extends ContentControllerEvent {
  final bool isForward;

  OnChangeContent({required this.isForward});
}

// class CheckContentAlreadyDowloadedById extends ContentControllerEvent {
//   final String primaryCategoryId;
//   final String secondaryCategoryId;
//   CheckContentAlreadyDowloadedById({
//     required this.primaryCategoryId,
//     required this.secondaryCategoryId,
//   });
// }
