part of 'ui_language_controller_cubit.dart';

@immutable
sealed class UiLanguageControllerState {
  final Map<String, dynamic>? selectdLang;

  const UiLanguageControllerState({this.selectdLang});
}

final class UiLanguageControllerInitialState
    extends UiLanguageControllerState {}

final class UiLanguageControllerErrorState extends UiLanguageControllerState {
  final String errro;

  const UiLanguageControllerErrorState({required this.errro});
}

final class UiLanguageControllerLoadingState extends UiLanguageControllerState {
  final String loadingFor;

  const UiLanguageControllerLoadingState({
    required this.loadingFor,
  });
}

final class UiLanguageControllerSuccessState extends UiLanguageControllerState {
  final List<UiLangModel> uiLanguages;
  final List<UiInstructionModel> instructions;

  const UiLanguageControllerSuccessState({
    required this.uiLanguages,
    super.selectdLang,
    required this.instructions,
  });
  UiLanguageControllerSuccessState copyWith({
    List<UiInstructionModel>? instructions,
    List<UiLangModel>? uiLanguages,
    Map<String, dynamic>? uiLang,
  }) {
    return UiLanguageControllerSuccessState(
      instructions: instructions ?? this.instructions,
      uiLanguages: uiLanguages ?? this.uiLanguages,
      selectdLang: uiLang ?? super.selectdLang,
    );
  }
}
