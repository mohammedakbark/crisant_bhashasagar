
import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/features/settings/data/models/ui_lang_model.dart';

class GetUiLanguagesRepo {
  static Future<ApiDataModel> onGetUiLangauge() async {
    try {
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.getUiLang,
        header: {"Content-Type": "application/json"},
      );
      if (response.status == 200) {
        final data = response.data as List;
      
        return ApiDataModel(
          isError: false,
          data: data.map((e) => UiDropLangModel.fromJson(e)).toList(),
        );
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
