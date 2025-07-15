import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/features/profile/data/models/profile_model.dart';

class UpdateProfileRepo {
  static Future<ApiDataModel> updateProfile({String ?name,}) async {
    try {
      final getToken = await CurrentUserPref.getUserData;

      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.updateProfile,
        body: {
          "customerName": "Anand API Test",
          "customerMobile": "7756873424",
          "customerPassword": "M@njula1105",
          "password_confirmation": "M@njula1105",
          "uiLanguageId": getToken.uiLangId, // Hindi & This is optional
        },
        header: {
          "Content-Type": "application/json",
          "Authorization": getToken.token,
        },
      );

      if (response.status == 200) {
        final data = response.data as Map<String, dynamic>;
        final user = data['user'] as Map<String, dynamic>;
        log(user.toString());
        return ApiDataModel(isError: false, data: ProfileModel.fromJson(user));
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
