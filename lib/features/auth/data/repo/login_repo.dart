import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/models/api_data_model.dart';

class LoginRepo {
  static Future<ApiDataModel> onLogin({
    required String mobileNumber,
    required String password,
    required String? uiLangId,
  }) async {
    try {
      Map<String, dynamic> body = {};
      if (uiLangId == null) {
        body = {"customerMobile": mobileNumber, "customerPassword": password};
      } else {
        body = {
          "customerMobile": mobileNumber,
          "customerPassword": password,
          "uiLanguageId": uiLangId,
        };
      }
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.login,
        body: body,
        header: {"Content-Type": "application/json"},
      );
      log(response.message);
      if (response.status == 200) {
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
