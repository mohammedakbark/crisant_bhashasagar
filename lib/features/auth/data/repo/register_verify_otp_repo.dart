import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/models/api_data_model.dart';

class RegisterVerifyOtpRepo {
static  Future<ApiDataModel> onVerifyOTP({
    required String? uiLangId,
    required int customerId,
    required String otp,
  }) async {
    try {
      Map<String, dynamic> body = {};
      if (uiLangId == null) {
        body = {"customerId": customerId, "customerOTP": otp};
      } else {
        body = {
          "customerId": customerId,
          "customerOTP": otp,
          "uiLanguageId": uiLangId, // Hindi & This is optional
        };
      }
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.regVerifyOTP,
        body: body,
        header: {"Content-Type": "application/json"},
      );

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
