import 'dart:developer';

import 'package:bashasagar/core/utils/show_messages.dart';
import 'package:bashasagar/features/settings/data/models/learn_language_model.dart';
import 'package:bashasagar/features/settings/data/repo/get_learn_languages_repo.dart';
import 'package:bashasagar/features/settings/data/repo/set_learn_lang_preference_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'learn_lang_selection_controller_state.dart';

class LearnLangControllerCubit extends Cubit<LearnLangControllerState> {
  LearnLangControllerCubit() : super(LearnLangControllerInitial());
  Future<void> onGetLearnLanguages() async {
    emit(LearnLangLoadingState());
    final response = await GetLearnLanguagesRepo.onGetLearnLanguages();
    if (response.isError) {
      emit(LearnLanguageErrorState(error: response.data as String));
    } else {
      emit(
        LearnLanguageSuccessState(
          languages: response.data as List<LearnLanguageModel>,
        ),
      );
    }
  }

  Future<void> onSetLearningLanguages() async {
    final currentState = state;
    if (currentState is LearnLanguageSuccessState) {
      emit(currentState.copyWith(isLoadingButton: true));
      final response = await SetLearnLangPreferenceRepo.setLearnlanguages(
        langIds:
            currentState.selectedLanguages.map((e) => e.languageId).toList(),
      );
      if (response.isError) {
        showToast(response.data.toString(),isError: true);
        emit(currentState.copyWith(isLoadingButton: false));
      } else {
        log(response.data.toString());
        showToast(response.data.toString());
        emit(currentState.copyWith(isLoadingButton: false));
      }
    }
  }

  void onAddToLangauge(LearnLanguageModel language) {
    final currentState = state;

    if (currentState is LearnLanguageSuccessState) {
      if (currentState.selectedLanguages.contains(language)) {
        final currentList = currentState.selectedLanguages;
        currentList.remove(language);
        emit(currentState.copyWith(selectedLanguages: currentList));
      } else {
        final currentList = currentState.selectedLanguages;
        emit(
          currentState.copyWith(selectedLanguages: [...currentList, language]),
        );
      }
    }
  }

  bool isLanguageSelected(LearnLanguageModel lang) =>
      state.selectedLanguages.contains(lang);
}
