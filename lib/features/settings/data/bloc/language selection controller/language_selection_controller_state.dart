part of 'language_selection_controller_cubit.dart';

@immutable
sealed class LanguageSelectionControllerState {
  final List<String> selectedLanguages;
  List<String> languages = ["English", "Hindi", "Kannad", "Malayalam"];

  LanguageSelectionControllerState({required this.selectedLanguages});
}

final class LanguageSelectionControllerInitial
    extends LanguageSelectionControllerState {
  LanguageSelectionControllerInitial(List<String> selectedLanguages)
    : super(selectedLanguages: selectedLanguages);

  LanguageSelectionControllerInitial copyWith({
    List<String>? selectedLanguages,
  }) {
    return LanguageSelectionControllerInitial(
      selectedLanguages ?? this.selectedLanguages,
    );
  }
}
