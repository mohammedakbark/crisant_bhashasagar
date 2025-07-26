import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';

class SetNotificationRepo {
  static Future<void> setPushToken(String pushToken) async {
    final getToken = await CurrentUserPref.getUserData;

    final response = await ApiConfig.postRequest(
      endpoint: ApiConst.setPushToke,
      body: {"pushToken": pushToken},
      header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${getToken.token}",
      },
    );
    //
    log(response.message);
  }
}
