import 'dart:developer';

import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/core/utils/show_messages.dart';
import 'package:bashasagar/features/settings/data/models/learn_language_model.dart';
import 'package:bashasagar/features/settings/data/models/settings_language_model.dart';
import 'package:bashasagar/features/settings/data/repo/get_learn_languages_repo.dart';
import 'package:bashasagar/features/settings/data/repo/set_learn_lang_preference_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'learn_lang_selection_controller_state.dart';

class LearnLangControllerCubit extends Cubit<LearnLangControllerState> {
  LearnLangControllerCubit() : super(LearnLangControllerInitial());
  Future<void> onGetSettingsLanguages() async {
    emit(LearnLangLoadingState());
    final response = await GetLearnLanguagesRepo.onGetSettingsLanguages();
    if (response.isError) {
      emit(LearnLanguageErrorState(error: response.data as String));
    } else {
      final langs = response.data as List<SettingsLanguageModel>;
      emit(
        LearnLanguageSuccessState(
          enableUpdateButton: false,
          selectedLanguages:
              langs.where((element) => element.selected == "YES").toList(),
          languages: langs,
        ),
      );
    }
  }

  Future<void> onSetLearningLanguages(BuildContext context) async {
    final currentState = state;
    if (currentState is LearnLanguageSuccessState) {
      if (currentState.selectedLanguages.isEmpty) {
        showSnackBar(
          context,
          "You should select atleast one language to proceed",
        );
        return;
      }
      emit(currentState.copyWith(isLoadingButton: true));
      final response = await SetLearnLangPreferenceRepo.setLearnlanguages(
        langIds:
            currentState.selectedLanguages.map((e) => e.languageId).toList(),
      );
      if (response.isError) {
        showToast(response.data.toString(), isError: true);
        emit(currentState.copyWith(isLoadingButton: false));
      } else {
        log(response.data.toString());
        showToast(response.data.toString());
        emit(currentState.copyWith(isLoadingButton: false));
      }
    }
  }

  // void onAddToLangauge(SettingsLanguageModel language) {
  //   final currentState = state;

  //   if (currentState is LearnLanguageSuccessState) {
  //     if (currentState.selectedLanguages.contains(language)) {
  //       final currentList = currentState.selectedLanguages;
  //       currentList.remove(language);

  //       emit(currentState.copyWith(selectedLanguages: currentList));
  //     } else {
  //       final currentList = currentState.selectedLanguages;

  //       emit(
  //         currentState.copyWith(selectedLanguages: [...currentList, language]),
  //       );
  //     }
  //   }
  // }]

  void onAddToLanguage(SettingsLanguageModel language) {
    final currentState = state;

    if (currentState is LearnLanguageSuccessState) {
      // Server-side selected items
      final serverItems =
          currentState.languages
              .where((element) => element.selected == "YES")
              .toList();

      // Create a new list from current selectedLanguages to avoid mutation
      final updatedList = List<SettingsLanguageModel>.from(
        currentState.selectedLanguages,
      );

      // Toggle logic: add if not present, remove if present
      if (updatedList.contains(language)) {
        updatedList.remove(language);
      } else {
        updatedList.add(language);
      }

      // Check if updatedList and serverItems have the same items
      bool enableButton = !_areListsEqual(updatedList, serverItems);

      emit(
        currentState.copyWith(
          selectedLanguages: updatedList,
          enableUpdateButton: enableButton,
        ),
      );
    }
  }

  bool _areListsEqual(
    List<SettingsLanguageModel> list1,
    List<SettingsLanguageModel> list2,
  ) {
    final set1 = Set.from(list1);
    final set2 = Set.from(list2);

    return set1.length == set2.length && set1.containsAll(set2);
  }

  bool isLanguageSelected(SettingsLanguageModel lang) =>
      state.selectedLanguages.contains(lang);
}
