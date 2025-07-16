import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/features/profile/data/models/profile_model.dart';

class UpdateProfileRepo {
  static Future<ApiDataModel> updateProfile({
    required String name,
    required String email,
    required String gender,
    required String age,
    required String address,
    String? password,
    String? confirmPassword,
  }) async {
    try {
      final getToken = await CurrentUserPref.getUserData;
      Map<String, dynamic> json = {};
      if (password != null && confirmPassword != null) {
        json = {
          "customerName": name,
          "customerGender": gender,
          "customerAge": age,
          "customerEmailAddress": email,
          "customerAddress": address,
          "customerPassword": password,
          "password_confirmation": confirmPassword,
          "uiLanguageId": getToken.uiLangId, // Hindi & This is optional
        };
      } else {
        json = {
          "customerName": name,
          "customerGender": gender,
          "customerAge": age,
          "customerEmailAddress": email,
          "customerAddress": address,

          "uiLanguageId": getToken.uiLangId, // Hindi & This is optional
        };
      }
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.updateProfile,
        body: json,
        header: {
          "Content-Type": "application/json",
          "Authorization": getToken.token,
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
