import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/core/utils/show_messages.dart';

class RegistrationRepo {
  static Future<ApiDataModel> onRegister({
    required String name,
    required String mobileNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final userData = await CurrentUserPref.getUserData;

      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.register,
        body: {
          "customerName": name,
          "customerMobile": mobileNumber,
          "customerPassword": password,
          "password_confirmation": confirmPassword,
          "uiLanguageId": userData.uiLangId,
        },
        header: {"Content-Type": "application/json"},
      );

      if (response.status == 200) {
        showToast(response.message);
        return ApiDataModel(isError: false, data: response.data ?? {});
      } else {
        log(response.message.toString());
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
