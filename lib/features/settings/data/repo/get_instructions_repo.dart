import 'dart:developer';

import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/models/api_data_model.dart';
import 'package:bashasagar/features/settings/data/models/ui_instruction_model.dart';

class GetInstructionsRepo {
  static Future<ApiDataModel> onGetInstructions() async {
    try {
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.getInstruction,
        header: {"Content-Type": "application/json"},
      );
      if (response.status == 200) {
        final data = response.data as List;
      
        return ApiDataModel(
          isError: false,
          data: data.map((e) => UiInstructionModel.fromJson(e)).toList(),
        );
      } else {
        return ApiDataModel(isError: true, data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true, data: e.toString());
    }
  }
}
