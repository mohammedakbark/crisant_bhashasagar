import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/core/utils/show_messages.dart';

class SetLearnLangPreferenceRepo {
  static Future<ApiDataModel> setLearnlanguages({
    required List<String> langIds,
  }) async {
    try {
      final userData = await CurrentUserPref.getUserData;
      final body = {"languagePreference":langIds.map((e) => {"languageId": e}).toList()};
      log(body.toString());
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.setLearnLanguge,
        body: body,
        header: {
          "Authorization": userData.token,
          "Content-Type": "application/json",
        },
      );

      if (response.status == 200) {
        showToast(response.message);
        return ApiDataModel(isError: false, data: response.message);
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
