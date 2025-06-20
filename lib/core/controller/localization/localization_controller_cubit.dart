import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'localization_controller_state.dart';

class LocalizationControllerCubit extends Cubit<LocalizationControllerState> {
  final List<Map<String, String>> languages = [
    {"title": "English", "value": "en"},
    {"title": "Hindi", "value": "hi"},
    {"title": "Kannada", "value": "ka"},
  ];
  LocalizationControllerCubit()
    : super(LocalizationControllerInitial(language: {}));
  Future<void> onchangeLangauge(
    BuildContext context,
    Map<String, dynamic> value,
  ) async {
    try {
      context.setLocale(Locale(value['value']));
      emit(LocalizationControllerInitial(language: value));
    } catch (e) {
      log(e.toString());
    }
  }

  void initCurrentLan(BuildContext context) {
    final code = context.locale.languageCode;
    emit(
      LocalizationControllerInitial(
        language: languages.firstWhere((element) => element['value'] == code),
      ),
    );
  }
}
