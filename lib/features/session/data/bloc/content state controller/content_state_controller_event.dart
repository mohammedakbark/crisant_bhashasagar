part of 'content_state_controller_bloc.dart';

@immutable
sealed class ContentStateControllerEvent {}

class LoadContentById extends ContentStateControllerEvent {
  final String primaryCategoryId;

  final String secondaryCategoryId;
  LoadContentById({
    required this.secondaryCategoryId,
    required this.primaryCategoryId,
  });
}

class OnChangeContent extends ContentStateControllerEvent {
  final bool isForward;
  final String primaryCategoryId;
  final String secondaryCategoryId;

  OnChangeContent({
    required this.isForward,
    required this.primaryCategoryId,
    required this.secondaryCategoryId,
  });
}

class TransliterateContent extends ContentStateControllerEvent {
  final String tergetLangugae;
  final String primaryCategoryId;
  TransliterateContent({
    required this.tergetLangugae,
    required this.primaryCategoryId,
  });
}

class InitPlayer extends ContentStateControllerEvent {}

class PlayAudio extends ContentStateControllerEvent {
  final String primaryCategoryId;

  final String secondaryCategoryId;

  PlayAudio({
    required this.primaryCategoryId,
    required this.secondaryCategoryId,
  });
}

class AudioCompleted extends ContentStateControllerEvent {}

class MarkCustomerProgress extends ContentStateControllerEvent {
  final String secondaryCategoryId;
  final String dateTime;

  MarkCustomerProgress({
    required this.secondaryCategoryId,
    required this.dateTime,
  });
}
