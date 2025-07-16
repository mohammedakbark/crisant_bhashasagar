part of 'content_state_controller_bloc.dart';

@immutable
sealed class ContentStateControllerState {}

final class ContentStateControllerInitial extends ContentStateControllerState {}

class ContentLoadFromLocalState extends ContentStateControllerState {
  final String secondaryCategoryId;
  final List<ContentJsonModel> jsonData;
  final ContentJsonModel currentFile;
  final int? currentIndex;
  final bool? isTransliterating;
  final String? tranlatedString;
  final Map<String, dynamic>? selectedLangToTransiliterate;
  final bool? isAudioPlaying;

  ContentLoadFromLocalState({
    required this.secondaryCategoryId,
    required this.jsonData,
    required this.currentFile,
    this.currentIndex = 0,
    this.isTransliterating,
    this.tranlatedString,
    this.selectedLangToTransiliterate,
    this.isAudioPlaying,
  });

  ContentLoadFromLocalState copyWith({
    ContentJsonModel? currentFile,
    int? currentIndex,
    bool? isTransliterating,
    String? tranlatedString,
    Map<String, dynamic>? selectedLangToTransiliterate,
    bool? isAudioPlaying,
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
    );
  }}