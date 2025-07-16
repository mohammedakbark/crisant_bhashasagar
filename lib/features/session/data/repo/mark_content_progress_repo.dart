import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';

class MarkContentProgressRepo {
  static Future<ApiDataModel> onMarlContentProgress(
    String secondaryCategoryId,
    String completedDateTime,
  ) async {
    try {
      final getData = await CurrentUserPref.getUserData;
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.markcustomerProgress,
        body: {
          "secondaryCategoryId": secondaryCategoryId,
          "completedDateTime": completedDateTime,
        },
        header: {
          "Authorization": getData.token,
          "Content-Type": "application/json",
        },
      );
      if (response.status == 200) {
        return ApiDataModel(isError: false, data: response.message);
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
