import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_selection_controller_state.dart';

class LanguageSelectionControllerCubit
    extends Cubit<LanguageSelectionControllerState> {
  LanguageSelectionControllerCubit()
    : super(LanguageSelectionControllerInitial([]));

  void onAddToLangauge(String language) {
    List<String> selectedLangauge = state.selectedLanguages;
    if (selectedLangauge.contains(language)) {
      selectedLangauge.remove(language);
    } else {
      selectedLangauge.add(language);
    }
    emit(LanguageSelectionControllerInitial(selectedLangauge));
  }

  bool isLanguageSelected(String lang) =>
      state.selectedLanguages.contains(lang);
}
