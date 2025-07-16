import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';


class TransliterateRepo {
  static Future<ApiDataModel> onTransliterate(
    String targetLanguage,
    String script,
  ) async {
    try {
      final getData = await CurrentUserPref.getUserData;
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.transliterate,
        body: {"targetLanguage": targetLanguage, "string": script},
        header: {
          "Authorization": getData.token,
          "Content-Type": "application/json",
        },
      );
      if (response.status == 200) {
        final data = response.data as String;

        return ApiDataModel(isError: false, data: data);
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
