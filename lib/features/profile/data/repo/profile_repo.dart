import 'package:bashasagar/core/config/api_config.dart';
import 'package:bashasagar/core/const/api_const.dart';

class ProfileRepo {
  Future<Map<String, dynamic>> onGetProfileInfo() async {
    try {
      final response = await ApiConfig.postRequest(
        endpoint: ApiConst.regResendOTP,
        header: {"Content-Type": "application/json", "Authorization": ""},
      );

      if (response.status == 200) {
        final data = response.data as Map<String, dynamic>;
        return {"error": false, "data": data};
      } else {
        return {"error": true, "data": response.message};
      }
    } catch (e) {
      return {"error": true, "data": e.toString()};
    }
  }
}
