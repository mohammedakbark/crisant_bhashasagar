part of 'learn_lang_selection_controller_cubit.dart';

@immutable
sealed class LearnLangControllerState {
  final List<LearnLanguageModel> selectedLanguages;

  const LearnLangControllerState({this.selectedLanguages = const []});
}

final class LearnLangControllerInitial extends LearnLangControllerState {
  // LearnLangControllerInitial(List<String> selectedLanguages)
  //   : super(selectedLanguages: selectedLanguages);

  // LearnLangControllerInitial copyWith({List<String>? selectedLanguages}) {
  //   return LearnLangControllerInitial(
  //     selectedLanguages ?? this.selectedLanguages,
  //   );
  // }
}

final class LearnLangLoadingState extends LearnLangControllerState {
  // LearnLangLoadingState({super.selectedLanguages = const []});
}

final class LearnLanguageSuccessState extends LearnLangControllerState {
  final List<LearnLanguageModel> languages;
  final bool isLoadingButton;

  const LearnLanguageSuccessState({
    required this.languages,
    super.selectedLanguages,
    this.isLoadingButton = false,
  });

  LearnLanguageSuccessState copyWith({
    List<LearnLanguageModel>? languages,
    List<LearnLanguageModel>? selectedLanguages,
    bool? isLoadingButton,
  }) {
    return LearnLanguageSuccessState(
      isLoadingButton: isLoadingButton ?? this.isLoadingButton,
      languages: languages ?? this.languages,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
    );
  }
}

final class LearnLanguageErrorState extends LearnLangControllerState {
  final String error;

  LearnLanguageErrorState({required this.error});
}
