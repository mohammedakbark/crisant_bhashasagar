import 'dart:developer';

import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/models/response_model.dart';
import 'package:dio/dio.dart';

class ApiConfig {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConst.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  static Future<DioResponseModel> postRequest({
    required String endpoint,
    required Map<String, dynamic> header,
    Object? body,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: header),
      );
      _checkTokenExpired(response.data);

      return DioResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        try {
          log("response 401  (No Error) POST");
          log(e.response!.data['message'].toString());
          // _checkTokenExpired(e.response!.data);
          return DioResponseModel.fromJson(e.response!.data);
        } catch (_) {
          log("response 401  (Error) POST");

          return DioResponseModel(
            data: null,
            error: true,
            message: "Failed to parse error response",
            status: e.response?.statusCode ?? 500,
          );
        }
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        log("Connection Error ! POST");
        return DioResponseModel(
          data: null,
          error: true,
          message: "No Internet Connection!",
          status: 503,
        );
      }
      log("Dio Error POST");
      return DioResponseModel(
        data: null,
        error: true,
        message: "Dio Error: ${e.message}",
        status: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      log("Unexpected Error POST");
      return DioResponseModel(
        data: null,
        error: true,
        message: "Unexpected Error: $e",
        status: 500,
      );
    }
  }

  //---------------------------GET

  static Future<DioResponseModel> getRequest({
    required String endpoint,
    required Map<String, dynamic> header,
    Object? body,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        data: body,
        options: Options(headers: header),
      );

      // Directly use response.data instead of decoding again
      // log(response.data.toString());
      _checkTokenExpired(response.data);
      return DioResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        try {
          log("response 401  (No Error)");
          log(e.response!.data['message'].toString());
          // _checkTokenExpired(e.response!.data);
          return DioResponseModel.fromJson(e.response!.data);
        } catch (_) {
          log("response 401  (Error)");

          return DioResponseModel(
            data: null,
            error: true,
            message: "Failed to parse error response",
            status: e.response?.statusCode ?? 500,
          );
        }
      }
      // 🔌 Handle no internet connection
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        log("Connection Error !");

        return DioResponseModel(
          data: null,
          error: true,
          message: "No Internet Connection!",
          status: 503,
        );
      }

      // 🧾 If server returned a valid response (like 401), parse that
      log("Dio Error");

      return DioResponseModel(
        data: null,
        error: true,
        message: "Dio Error: ${e.message}",
        status: e.response?.statusCode ?? 500,
      );
    } catch (e) {
      log("Unexpected Error");

      return DioResponseModel(
        data: null,
        error: true,
        message: "Unexpected Error: $e",
        status: 500,
      );
    }
  }

  static void _checkTokenExpired(data) async {
    // if (data['error'] == true && data['message'] == "token expired") {
    //   ProfileScreen().onLogout(rootNavigatorKey.currentContext!);
    //   // await ProfileScreen().on(rootNavigatorKey.currentContext!);
    // }
  }
}
