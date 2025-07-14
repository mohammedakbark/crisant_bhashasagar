import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/features/session/data/models/primary_category_model.dart';
import 'package:bashasagar/features/settings/data/models/learn_language_model.dart';

class GetPrimaryCategoryRepo {
  static Future<ApiDataModel> onGetPrimaryCategpory(String langId) async {
    try {
      final getData = await CurrentUserPref.getUserData;
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.primaryCategory,
        body: {"languageId": langId, "uiLanguageId": getData.uiLangId},
        header: {
          "Authorization": getData.token,
          "Content-Type": "application/json",
        },
      );
      if (response.status == 200) {
        final data = response.data as List;

        return ApiDataModel(
          isError: false,
          data: data.map((e) => PrimaryCategoryModel.fromJson(e)).toList(),
        );
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
