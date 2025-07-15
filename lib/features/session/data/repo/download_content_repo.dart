// import 'package:bashasagar/core/const/api_const.dart';
// import 'package:bashasagar/core/controller/current_user_pref.dart';
// import 'package:bashasagar/core/utils/permission_handler.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';

// class DownloadContentRepo {
//   static Dio dio = Dio(
//     BaseOptions(
//       baseUrl: ApiConst.baseUrl,
//       connectTimeout: Duration(seconds: 10),
//       receiveTimeout: Duration(seconds: 10),
//     ),
//   );
//   static Future<Response?> downloadZip(
//     String primaryCategoryId,
//     String secondaryCategoryId,
//     String fileName,
//   ) async {
//     try {
//       if (!await AppPermissions.requestStoragePermission()) {
//         throw Exception('Storage permission denied');
//       }

//       final dir = await getApplicationDocumentsDirectory();
//       final filePath = '${dir.path}/$fileName';

//       final getData = await CurrentUserPref.getUserData;

//       final response = await dio.download(
//         "${ApiConst.contentUrl}?primaryCategoryId=$primaryCategoryId&secondaryCategoryId=$secondaryCategoryId",
//         fileName,
//         options: Options(
//           headers: {
//             "Authorization": getData.token,
//             // "Content-Type": "application/json",
//           },
//         ),
//       );
//       if (response.statusCode != 200) return null;
//       return response;
//     } catch (e) {
//       return null;
//     }
//   }
// }
