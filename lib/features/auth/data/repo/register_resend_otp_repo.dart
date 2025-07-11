import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/models/api_data_model.dart';

class RegisterResendOtpRepo {
 static Future<ApiDataModel> onResendOTP({
    required String? uiLangId,
    required int customerId,
  }) async {
    try {
      Map<String, dynamic> body = {};
      if (uiLangId == null) {
        body = {
          "customerId": customerId,
          
        };
      } else {
        body = {
          "customerId": customerId,
        
          "uiLanguageId":uiLangId // Hindi & This is optional
        };
      }
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.regResendOTP,
        body: body,
        header: {"Content-Type": "application/json"},
      );

      if (response.status == 200) {
        return ApiDataModel(isError: false,data: response.message);
      } else {
        return ApiDataModel(isError: true,data: response.message);
      }
    } catch (e) {
      return ApiDataModel(isError: true,data: e.toString());
    }
  }
}
