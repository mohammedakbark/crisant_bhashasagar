import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/core/utils/show_messages.dart';

class LoginRepo {
  static Future<ApiDataModel> onLogin({
    required String mobileNumber,
    required String password,
  }) async {
    try {
      final userData = await CurrentUserPref.getUserData;
      log(userData.uiLangId.toString());
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.login,
        body: {
          "customerMobile": mobileNumber,
          "customerPassword": password,
          "uiLanguageId": userData.uiLangId,
        },
        header: {"Content-Type": "application/json"},
      );
      log(response.message);
      if (response.status == 200) {
        showToast(response.message);
        final data = response.data as Map<String, dynamic>;
        return ApiDataModel(isError: false, data: data);
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
