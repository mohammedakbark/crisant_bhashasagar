import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/features/home/data/models/dashboard_progress_model.dart';
import 'package:bashasagar/features/search/data/models/search_word_model.dart';

class SearchWordRepo {
  static Future<ApiDataModel> onSearchWord(
    String languageId,
    String query,
  ) async {
    try {
      log("searcing word........");
      log("lang Id : $languageId");
      log("qeury  $query");
      final getData = await CurrentUserPref.getUserData;
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.searchWord,
        body: {"languageId": languageId, "query": query},
        header: {
          "Authorization": getData.token,
          "Content-Type": "application/json",
        },
      );
      if (response.status == 200) {
        final data = response.data as List;

        return ApiDataModel(
          isError: false,
          data: data.map((e) => SearchWordModel.fromJson(e)).toList(),
        );
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
