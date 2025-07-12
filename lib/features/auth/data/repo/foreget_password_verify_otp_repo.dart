import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/core/utils/show_messages.dart';

class ForegetPasswordVerifyOtpRepo {
  static Future<ApiDataModel> onVerifyOTP({
    required String customerId,
    required String otp,
  }) async {
    try {
      final userData = await CurrentUserPref.getUserData;

      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.forgetPasswordVerify,
        body: {
          "customerId": customerId,
          "customerOTP": otp,
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
