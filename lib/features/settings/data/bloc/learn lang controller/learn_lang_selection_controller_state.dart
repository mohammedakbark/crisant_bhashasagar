part of 'learn_lang_selection_controller_cubit.dart';

@immutable
sealed class LearnLangControllerState {
  final List<SettingsLanguageModel> selectedLanguages;

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
  final List<SettingsLanguageModel> languages;
  final bool isLoadingButton;
  final bool enableUpdateButton;

  const LearnLanguageSuccessState({
    required this.languages,
    super.selectedLanguages,
    this.isLoadingButton = false,
    required this.enableUpdateButton,
  });

  LearnLanguageSuccessState copyWith({
    List<SettingsLanguageModel>? languages,
    List<SettingsLanguageModel>? selectedLanguages,
    bool? isLoadingButton,
    bool?enableUpdateButton
  }) {
    return LearnLanguageSuccessState(
      enableUpdateButton:enableUpdateButton??this.enableUpdateButton,
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
