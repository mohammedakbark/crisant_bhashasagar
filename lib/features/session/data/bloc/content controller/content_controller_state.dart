part of 'content_controller_bloc.dart';

@immutable
abstract class ContentControllerState {}

class ContentControllerInitialState extends ContentControllerState {}

class ContentDownloadProgressState extends ContentControllerState {
  // final String secondaryCategoryId;
  // final String progress;
  // ContentDownloadProgressState({
  //   required this.secondaryCategoryId,
  //   required this.progress,
  // });
  final List<Map<String, dynamic>> progressingData;

  ContentDownloadProgressState({required this.progressingData});
}

class ContentDownloadErrorState extends ContentControllerState {
  final String secondaryCategoryId;
  final String error;
  ContentDownloadErrorState({
    required this.secondaryCategoryId,
    required this.error,
  });
}

class ContentLoadErrorState extends ContentControllerState {
  final String secondaryCategoryId;
  final String error;
  ContentLoadErrorState({
    required this.secondaryCategoryId,
    required this.error,
  });
}

class ContentLoadFromLocalState extends ContentControllerState {
  final String secondaryCategoryId;
  final List<ContentJsonModel> jsonData;
  final ContentJsonModel currentFile;
  final int? currentIndex;
  final bool? isTransliterating;
  final String? tranlatedString;
  final Map<String, dynamic>? selectedLangToTransiliterate;
  final bool? isAudioPlaying;
  final List<VersionCheckDataModel> versions;

  ContentLoadFromLocalState({
    required this.secondaryCategoryId,
    required this.jsonData,
    required this.currentFile,
    this.currentIndex = 0,
    this.isTransliterating,
    this.tranlatedString,
    this.selectedLangToTransiliterate,
    this.isAudioPlaying,
    this.versions = const [],
  });

  ContentLoadFromLocalState copyWith({
    ContentJsonModel? currentFile,
    int? currentIndex,
    bool? isTransliterating,
    String? tranlatedString,
    Map<String, dynamic>? selectedLangToTransiliterate,
    bool? isAudioPlaying,
    List<VersionCheckDataModel>? versions,
  }) {
    return ContentLoadFromLocalState(
      currentFile: currentFile ?? this.currentFile,
      jsonData: jsonData,
      secondaryCategoryId: secondaryCategoryId,
      currentIndex: currentIndex ?? this.currentIndex,

      tranlatedString: tranlatedString ?? this.tranlatedString,
      isTransliterating: isTransliterating ?? this.isTransliterating,
      selectedLangToTransiliterate:
          selectedLangToTransiliterate ?? this.selectedLangToTransiliterate,
      isAudioPlaying: isAudioPlaying ?? this.isAudioPlaying,
      versions: versions ?? this.versions,
    );
  }
}
