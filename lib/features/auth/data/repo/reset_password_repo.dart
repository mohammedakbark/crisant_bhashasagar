import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/core/utils/show_messages.dart';

class ResetPasswordRepo {
  static Future<ApiDataModel> onResetPassword({
    required String customerId,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final userData = await CurrentUserPref.getUserData;

      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.resetPassword,
        body: {
          "customerId": customerId,
          "customerPassword": password,
          "password_confirmation": confirmPassword,
          "uiLanguageId": userData.uiLangId,
        },
        header: {"Content-Type": "application/json"},
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
