import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/features/session/data/models/secondary_category_model.dart';
import 'package:bashasagar/features/settings/data/models/learn_language_model.dart';

class GetSecondaryCategoryRepo {
  static Future<ApiDataModel> onGetSeondaryCategory(
    String langId,
    String primaryCategoryId,
  ) async {
    try {
      final getData = await CurrentUserPref.getUserData;
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.secondaryCategroy,
        body: {
          "languageId": langId,
          "primaryCategoryId": primaryCategoryId,
          "uiLanguageId": getData.uiLangId,
        },
        header: {
          "Authorization": getData.token,
          "Content-Type": "application/json",
        },
      );
      if (response.status == 200) {
        final data = response.data as List;


        return ApiDataModel(
          isError: false,
          data: data.map((e) => SecondaryCategoryModel.fromJson(e)).toList(),
        );
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
