import 'dart:developer';

import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/current_user_model.dart';
import 'package:bashasagar/features/settings/data/models/ui_instruction_model.dart';
import 'package:bashasagar/features/settings/data/models/ui_lang_model.dart';
import 'package:bashasagar/features/settings/data/repo/get_instructions_repo.dart';
import 'package:bashasagar/features/settings/data/repo/get_ui_languages_repo.dart';
import 'package:bashasagar/features/settings/data/repo/set_ui_language_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

part 'ui_language_controller_state.dart';

class UiLanguageControllerCubit extends Cubit<UiLanguageControllerState> {
  static const _currentlanguage = "currentLanguageBox";
  static const _instruction = "instructions";
  UiLanguageControllerCubit() : super(UiLanguageControllerInitialState());

  Future<void> initGetStartScreen() async {
    try {
      emit(
        UiLanguageControllerLoadingState(loadingFor: "Fetching instructions.."),
      );
      final insRespo = await GetInstructionsRepo.onGetInstructions();
      if (!insRespo.isError) {
        await _storeInstructions(insRespo.data as List<UiInstructionModel>);
        final instructions = await getInstructions;

        emit(
          UiLanguageControllerLoadingState(loadingFor: "Fetching languages.."),
        );
        final uiLangRespo = await GetUiLanguagesRepo.onGetUiLangauge();
        if (!uiLangRespo.isError) {
          final uiLangd = uiLangRespo.data as List<UiLangModel>;
          emit(
            UiLanguageControllerSuccessState(
              uiLanguages: uiLangd,
              instructions: instructions,
            ),
          );
        } else {
          emit(
            UiLanguageControllerErrorState(errro: uiLangRespo.data as String),
          );
        }
      } else {
        emit(UiLanguageControllerErrorState(errro: insRespo.data as String));
      }
    } catch (e) {
      emit(UiLanguageControllerErrorState(errro: e.toString()));
    }
  }

  Future<void> updateUiLanguageInServer(String uiLangId) async {
    final response = await SetUiLanguageRepo.setUiLang(langId: "uiLangId");
  }

  //   LANGUAGE CHANGER

  Future<void> onSelectlanguage({required Map<String, dynamic> lang}) async {
    final currentState = state;
    if (currentState is UiLanguageControllerSuccessState) {
      final currentLanguageData =
          currentState.instructions
              .where((element) => element.uiLanguageId == lang['value'])
              .toList();
      CurrentUserPref.setUserData(CurrentUserModel(uiLangId: lang['value']));
      await _saveSelctedLanguagePreferen(currentLanguageData);
      emit(currentState.copyWith(uiLang: lang));
    }
  }

  // HIVE FUNCTIONS

  // --- store entire language
  Future<void> _storeInstructions(List<UiInstructionModel> model) async {
    emit(
      UiLanguageControllerLoadingState(
        loadingFor: "Downloading instructions..",
      ),
    );
    final instructionBox = await Hive.openBox<UiInstructionModel>(_instruction);

    await instructionBox.clear();
    final clonedList =
        model.map((e) {
          return UiInstructionModel.fromJson(e.toJson());
        }).toList();
    await instructionBox.addAll(clonedList);
  }

  // -----retrive entire language
  static Future<List<UiInstructionModel>> get getInstructions async {
    final instructionBox = await Hive.openBox<UiInstructionModel>(_instruction);
    return instructionBox.values.toList();
  }

  //-------------------------------------------------------------
  // ---- Store currentLanguage
  Future<void> _saveSelctedLanguagePreferen(
    List<UiInstructionModel> model,
  ) async {
    final currentLangBox = await Hive.openBox<UiInstructionModel>(
      _currentlanguage,
    );
    await currentLangBox.clear();
    final clonedList =
        model.map((e) {
          return UiInstructionModel.fromJson(e.toJson());
        }).toList();
    await currentLangBox.addAll(clonedList);
  }
  // -----retrive current language

  static Future<List<UiInstructionModel>> get getCurrentUILanguage async {
    final currentLangBox = await Hive.openBox<UiInstructionModel>(
      _currentlanguage,
    );
    return currentLangBox.values.toList();
  }
}
