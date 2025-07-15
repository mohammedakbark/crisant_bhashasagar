part of 'ui_language_controller_cubit.dart';

@immutable
sealed class UiLanguageControllerState {
  final Map<String, dynamic>? selectdLang;
  final List<Map<String, dynamic>> convertedLangsToDropDown;

  const UiLanguageControllerState({
    this.selectdLang,
    this.convertedLangsToDropDown = const [],
  });
}

final class UiLanguageControllerInitialState
    extends UiLanguageControllerState {}

final class UiLanguageControllerErrorState extends UiLanguageControllerState {
  final String errro;

  const UiLanguageControllerErrorState({required this.errro});
}

final class UiLanguageControllerLoadingState extends UiLanguageControllerState {
  final String loadingFor;

  const UiLanguageControllerLoadingState({required this.loadingFor});
}

final class UiLanguageControllerSuccessState extends UiLanguageControllerState {
  final List<UiDropLangModel> uiDropLanguages;
  final List<UiInstructionModel> instructions;

  const UiLanguageControllerSuccessState({
    required this.uiDropLanguages,
    super.selectdLang,
    required this.instructions,
    super.convertedLangsToDropDown,
  });
  UiLanguageControllerSuccessState copyWith({
    List<UiInstructionModel>? instructions,
    List<UiDropLangModel>? uiDropLanguages,
    Map<String, dynamic>? uiLang,
    List<Map<String, dynamic>>? convertedLangsToDropDown,
  }) {
    return UiLanguageControllerSuccessState(
      instructions: instructions ?? this.instructions,
      uiDropLanguages: uiDropLanguages ?? this.uiDropLanguages,
      selectdLang: uiLang ?? super.selectdLang,
      convertedLangsToDropDown:
          convertedLangsToDropDown ?? this.convertedLangsToDropDown,
    );
  }
}
