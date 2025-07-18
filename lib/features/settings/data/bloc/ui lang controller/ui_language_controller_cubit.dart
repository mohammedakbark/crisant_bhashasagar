import 'dart:developer';

import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/current_user_model.dart';
import 'package:bashasagar/features/settings/data/models/ui_instruction_model.dart';
import 'package:bashasagar/features/settings/data/models/ui_lang_model.dart';
import 'package:bashasagar/features/settings/data/repo/get_instructions_repo.dart';
import 'package:bashasagar/features/settings/data/repo/get_ui_languages_repo.dart';
import 'package:bashasagar/features/settings/data/repo/set_ui_language_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
          UiLanguageControllerSuccessState(
            uiDropLanguages: [],
            allInstructions: instructions,
          ),
        );
        emit(
          UiLanguageControllerLoadingState(loadingFor: "Fetching languages.."),
        );
        log("Fetching languges for dropdown...");

        await getLanguagesForDropdown();

        // final uiLangRespo = await GetUiLanguagesRepo.onGetUiLangauge();
        // if (!uiLangRespo.isError) {
        //   final uiLangd = uiLangRespo.data as List<UiDropLangModel>;
        //   emit(
        //     UiLanguageControllerSuccessState(
        //       uiDropLanguages: uiLangd,
        //       instructions: instructions,
        //     ),
        //   );
        // } else {
        //   log("Error -> Fetching ui instruction");

        //   emit(
        //     UiLanguageControllerErrorState(errro: uiLangRespo.data as String),
        //   );
        // }
      } else {
        log("Error -> Fetching languges for dropdown...");
        emit(UiLanguageControllerErrorState(errro: insRespo.data as String));
      }
    } catch (e) {
      log("Catch Error -> ${e.toString()}");
      emit(UiLanguageControllerErrorState(errro: e.toString()));
    }
  }

  //------------------------S E T T I N G S --------------------------

  Future<void> getLanguagesForDropdown() async {
    // GET CURRENT LANGUAGE FOR INTIALIZING
    log("Initializing current language...");
    final currrentUiLang = await getCurrentUILanguageInstructionsFromHive;
    final allLanguages = await getAllInstructionsFromHive;

    final getUserData = await CurrentUserPref.getUserData;
    final id = getUserData.uiLangId;
    UiInstructionModel? currentLanguage;
    if (currrentUiLang.isNotEmpty) {
      currentLanguage = currrentUiLang.firstWhere(
        (element) => element.page == "LANGUAGE" && element.uiLanguageId == id,
      );
    } else {
      currentLanguage = allLanguages.firstWhere(
        (element) => element.page == "LANGUAGE" && element.uiLanguageId == id,
      );
    }

    log("Fetching languges for dropdown...");
    final uiLangRespo = await GetUiLanguagesRepo.onGetUiLangauge();
    if (!uiLangRespo.isError) {
      final uiLangd = uiLangRespo.data as List<UiDropLangModel>;
      // --------------Convert the drop langs to current language

      final convertedLanguagesForDropdwn =
          await _convertDropDownLanguagesToCurrentLanguage(uiLangd);
      emit(
        UiLanguageControllerSuccessState(
          convertedLangsToDropDown: convertedLanguagesForDropdwn,
          selectdLang:
              currentLanguage != null
                  ? {
                    "value": currentLanguage.uiLanguageId,
                    "title": currentLanguage.uiText,
                  }
                  : null,
          uiDropLanguages: uiLangd,
          allInstructions: [],
        ),
      );
    } else {
      emit(UiLanguageControllerErrorState(errro: uiLangRespo.data as String));
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

  //   LANGUAGE CHANGER

  void onSelectLanguage({required Map<String, dynamic> lang}) {
    final currentState = state;
    if (currentState is UiLanguageControllerSuccessState) {
      bool enableButton = false;
      if (currentState.selectdLang!["value"] != lang['value']) {
        enableButton = true;
      }
      emit(
        currentState.copyWith(uiLang: lang, enableUpdateButton: enableButton),
      );
    }
  }

  Future<void> onChangeEntireUiLanguage({
    required Map<String, dynamic> lang,
  }) async {
    final currentState = state;
    log("My Current Lang Id :${lang['value']}");
    if (currentState is UiLanguageControllerSuccessState) {
      emit(currentState.copyWith(isLoading: true));
      log("taking the selected lang instruction from all instruction HIVE....");
      final instructions = await getAllInstructionsFromHive;
      final currentLanguageData =
          instructions
              .where((element) => element.uiLanguageId == lang['value'])
              .toList();
      await CurrentUserPref.setUserData(
        CurrentUserModel(uiLangId: lang['value']),
      );
      if (currentLanguageData.isEmpty) {
        log("Error -> No Data From Selected Language ---------");
      }

      await _saveSelctedUiLanguageInstructionPreferen(currentLanguageData);
      final convertedLangFOrDropDown =
          await _convertDropDownLanguagesToCurrentLanguage(
            currentState.uiDropLanguages,
          );

      emit(
        currentState.copyWith(
          convertedLangsToDropDown: convertedLangFOrDropDown,
          uiLang: lang,
          isLoading: false,
        ),
      );
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

  // delete entire instructions
  static Future<void> _deleteEntireInstructions() async {
    final instructionBox = await Hive.openBox<UiInstructionModel>(_instruction);

    await instructionBox.clear();
  }

  //-------------------------------------------------------------
  // ---- Store currentLanguage
  Future<void> _saveSelctedUiLanguageInstructionPreferen(
    List<UiInstructionModel> model,
  ) async {
    log("Saving new instruction ....");
    final currentLangBox = await Hive.openBox<UiInstructionModel>(
      _currentlanguage,
    );
    await currentLangBox.clear();
    final clonedList =
        model.map((e) {
          return UiInstructionModel.fromJson(e.toJson());
        }).toList();
    await currentLangBox.addAll(clonedList);
    log("Saved new instruction ....");
  }
  // -----retrive current language

  static Future<List<UiInstructionModel>>
  get getCurrentUILanguageInstructionsFromHive async {
    final currentLangBox = await Hive.openBox<UiInstructionModel>(
      _currentlanguage,
    );
    return currentLangBox.values.toList();
  }
  // delete current lang instructions

  static Future<void> _deleteUiInstructions() async {
    final currentLangBox = await Hive.openBox<UiInstructionModel>(
      _currentlanguage,
    );

    await currentLangBox.clear();
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
        return uiText;
      }

      return newData.uiText;
    } else {
      log("isInBox is false, returning original text");
      return uiText;
    }
  }

  Future<List<Map<String, dynamic>>> _convertDropDownLanguagesToCurrentLanguage(
    List<UiDropLangModel> uiDropLanguages,
  ) async {
    List<Map<String, dynamic>> newLanguages = [];

    for (var lang in uiDropLanguages) {
      final uiText = await findText("LANGUAGE", lang.uiLanguageName);
      newLanguages.add({
        "title": uiText,
        "value": lang.uiLanguageId,
        "icon": lang.uiImageLight,
      });
    }
    return newLanguages;
  }

  // CLEAR ALL

  static Future<void> clearAll() async {
    await _deleteEntireInstructions();
    await _deleteUiInstructions();
  }
}
