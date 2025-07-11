import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/models/api_data_model.dart';

class RegistrationRepo {
  static Future<ApiDataModel> onRegister({
    required String name,
    required String mobileNumber,
    required String password,
    required String confirmPassword,
    required String? uiLangId,
  }) async {
    try {
      Map<String, dynamic> body = {};
      if (uiLangId == null) {
        body = {
          "customerName": name,
          "customerMobile": mobileNumber,
          "customerPassword": password,
          "password_confirmation": confirmPassword,
        };
      } else {
        body = {
          "customerName": name,
          "customerMobile": mobileNumber,
          "customerPassword": password,
          "password_confirmation": confirmPassword,
          "uiLanguageId": uiLangId,
        };
      }
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.register,
        body: body,
        header: {"Content-Type": "application/json"},
      );

      if (response.status == 200) {
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
