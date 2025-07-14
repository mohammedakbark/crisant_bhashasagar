import 'dart:developer';

import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:bashasagar/features/settings/data/models/ui_created_at.dart';
import 'package:bashasagar/features/settings/data/models/ui_instruction_model.dart';

class GetUiLanguage  {
  final List<UiInstructionModel> uiInstructions;
  static String? _currentPage;

  GetUiLanguage._(this.uiInstructions);

  static Future<GetUiLanguage> create(String currentpage) async {
    _currentPage = currentpage;
    // Assuming this returns List<UiInstructionModel>
    final instructions = await UiLanguageControllerCubit.getCurrentUILanguageFromHive;
    if (instructions.isNotEmpty) {
      log("USED SELECTED LANGUGE");
      return GetUiLanguage._(instructions);
    } else {
      log("USED DEFAULT LANGUGE");

      final instructions = await UiLanguageControllerCubit.getAllInstructionsFromHive;
      final englishInstructions =
          instructions.where((element) => element.uiLanguageId == "1").toList();
      return GetUiLanguage._(englishInstructions);
    }
  }

  String uiText({required String placeHolder}) {
    // log(uiInstructions.length.toString());
    return uiInstructions
        .firstWhere(
          (element) =>
              element.page == _currentPage &&
              element.placeholderId == placeHolder,
          orElse:
              () => UiInstructionModel(
                instructionId: '',
                uiLanguageId: '',
                page: '',
                placeholderId: '',
                uiText: 'text not found!',
                createdBy: '',
                createdAt: UiLangCreatedAt(
                  date: '',
                  timezone: "",
                  timezoneType: 0,
                ), // replace with your dummy createdAt model
                modifiedAt: DateTime.now(),
              ),
        )
        .uiText;
  }
}
