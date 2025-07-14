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
      log("Fetching all ui instructions...");
      emit(
        UiLanguageControllerLoadingState(loadingFor: "Fetching instructions.."),
      );
      final insRespo = await GetInstructionsRepo.onGetInstructions();
      if (!insRespo.isError) {
        log("Store all app instructions .....");
        await _storeInstructions(insRespo.data as List<UiInstructionModel>);
        final instructions = await getAllInstructionsFromHive;

        emit(
          UiLanguageControllerLoadingState(loadingFor: "Fetching languages.."),
        );
        log("Fetching languges for dropdown...");

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
          log("Error -> Fetching ui instruction");

          emit(
            UiLanguageControllerErrorState(errro: uiLangRespo.data as String),
          );
        }
      } else {
        log("Error -> Fetching languges for dropdown...");
        emit(UiLanguageControllerErrorState(errro: insRespo.data as String));
      }
    } catch (e) {
      log("Catch Error -> ${e.toString()}");
      emit(UiLanguageControllerErrorState(errro: e.toString()));
    }
  }

  Future<void> updateUiLanguageInServer() async {
    final getUserData = await CurrentUserPref.getUserData;
    log("Ui Lang ID to Store Server: ${getUserData.uiLangId} ");

    final response = await SetUiLanguageRepo.setUiLang(
      langId: getUserData.uiLangId ?? "1",
    );

    if (response.isError) {
      log("Error while storing the language :-  ${response.data}");
    } else {
      log("Storing ui language success${response.data}");
    }
  }

  Future<void> getLanguages() async {
    log("Fetching languges for dropdown...");

    final uiLangRespo = await GetUiLanguagesRepo.onGetUiLangauge();
    if (!uiLangRespo.isError) {
      final uiLangd = uiLangRespo.data as List<UiLangModel>;
      emit(
        UiLanguageControllerSuccessState(
          uiLanguages: uiLangd,
          instructions: [],
        ),
      );
    } else {
      emit(UiLanguageControllerErrorState(errro: uiLangRespo.data as String));
    }
  }

  //   LANGUAGE CHANGER

  Future<void> onSelectlanguage({required Map<String, dynamic> lang}) async {
    final currentState = state;
    log("My Current Lang Id :${lang['value']}");
    if (currentState is UiLanguageControllerSuccessState) {
      final instructions = await getAllInstructionsFromHive;
      final currentLanguageData =
          instructions
              .where((element) => element.uiLanguageId == lang['value'])
              .toList();
      await CurrentUserPref.setUserData(
        CurrentUserModel(uiLangId: lang['value']),
      );
      if (currentLanguageData.isEmpty) {
        log("No Data From Selected Language");
      }

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
  static Future<List<UiInstructionModel>> get getAllInstructionsFromHive async {
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

  static Future<List<UiInstructionModel>>
  get getCurrentUILanguageFromHive async {
    final currentLangBox = await Hive.openBox<UiInstructionModel>(
      _currentlanguage,
    );
    return currentLangBox.values.toList();
  }

  // F I N D LANG T E X T
  Future<String> findText(String page, String uiText) async {
    final instructions = await getAllInstructionsFromHive;
    final userData = await CurrentUserPref.getUserData;

    // log("User lang Id =${userData.uiLangId}");

    UiInstructionModel? data;

    try {
      data = instructions.firstWhere(
        (element) => element.page == page && element.uiText == uiText,
      );
    } catch (e) {
      // log("No matching instruction for page=$page and uiText=$uiText");
      return uiText;
    }

    if (data.isInBox) {
      final palceHolderId = data.placeholderId;
      final userUiLangId = userData.uiLangId;

      UiInstructionModel? newData;

      try {
        newData = instructions.firstWhere(
          (element) =>
              element.placeholderId == palceHolderId &&
              element.uiLanguageId == userUiLangId,
        );
      } catch (e) {
        // log(
        //   "No translated data found for placeholderId=$palceHolderId and uiLanguageId=$userUiLangId",
        // );
        return uiText;
      }

      // log("-------------");
      // log(newData.uiText);
      return newData.uiText;
    } else {
      log("isInBox is false, returning original text");
      return uiText;
    }
  }
}
