part of 'content_controller_bloc.dart';

@immutable
abstract class ContentControllerState {}

class ContentControllerInitialState extends ContentControllerState {}

class ContentDownloadProgressState extends ContentControllerState {
  final String secondaryCategoryId;
  final String progress;
  ContentDownloadProgressState({
    required this.secondaryCategoryId,
    required this.progress,
  });
}

// class ContentDownloadSuccessState extends ContentControllerState {
//   final String secondaryCategoryId;
//   final List<ContentJsonModel> jsonData;
//   ContentDownloadSuccessState({
//     required this.secondaryCategoryId,
//     required this.jsonData,
//   });
// }

class ContentDownloadErrorState extends ContentControllerState {
  final String secondaryCategoryId;
  final String error;
  ContentDownloadErrorState({
    required this.secondaryCategoryId,
    required this.error,
  });
}

class ContentLoadFromLocalState extends ContentControllerState {
  final String secondaryCategoryId;
  final List<ContentJsonModel> jsonData;
  final ContentJsonModel currentFile;
  final int? currentIndex;
  ContentLoadFromLocalState({
    required this.secondaryCategoryId,
    required this.jsonData,
    required this.currentFile,
    this.currentIndex = 0,
  });

  ContentLoadFromLocalState copyWith(
    ContentJsonModel? currentFile,
    int? currentIndex,
  ) {
    return ContentLoadFromLocalState(
      currentFile: currentFile ?? this.currentFile,
      jsonData: jsonData,
      secondaryCategoryId: secondaryCategoryId,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class ContentLoadErrorState extends ContentControllerState {
  final String secondaryCategoryId;
  final String error;
  ContentLoadErrorState({
    required this.secondaryCategoryId,
    required this.error,
  });
}
