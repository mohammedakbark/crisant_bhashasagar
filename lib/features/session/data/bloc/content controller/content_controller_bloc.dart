// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:bashasagar/core/controller/current_user_pref.dart';
// import 'package:path/path.dart' as path;

// import 'package:archive/archive_io.dart';
// import 'package:bashasagar/core/const/api_const.dart';
// import 'package:bashasagar/core/utils/permission_handler.dart';
// import 'package:bashasagar/features/session/data/models/content_json_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:meta/meta.dart';
// import 'package:path_provider/path_provider.dart';

// part 'content_controller_event.dart';
// part 'content_controller_state.dart';

// class ContentControllerBloc
//     extends Bloc<ContentControllerEvent, ContentControllerState> {
//   ContentControllerBloc() : super(ContentControllerInitialState()) {
//     on<DownloadContentById>(_downloadContentById);
//     on<LoadContentById>(_loadContentById);
//   }

//   static const zipPath = "app_content.zip";
//   static const extractedContentPath = "extracted_content";
//   static Dio dio = Dio(
//     BaseOptions(
//       baseUrl: ApiConst.baseUrl,
//       connectTimeout: Duration(seconds: 10),
//       receiveTimeout: Duration(seconds: 10),
//     ),
//   );

//   Future<void> _downloadZipAndExtract(
//     DownloadAndExtractContentZip event,
//     Emitter<ContentControllerState> emit,
//   ) async {
//     try {
//       if (!await AppPermissions.requestStoragePermission()) {
//         emit(
//           ContentControllerDownloadAndExtractErrorState(
//             error: 'Storage permission denied',
//           ),
//         );
//         throw Exception('Storage permission denied');
//       }
//       final getData = await CurrentUserPref.getUserData;
//       emit(ContentControllerDownloadLoadingState(percentage: "0%"));
//       final zipFilePath = await _getPath(
//         zipPath,
//         event.primaruCategoryId,
//         event.secondaryCategoryId,
//       );

//       final currentState = state;
//       log('Downloading zip file...');
//       await dio.download(
//         "${ApiConst.contentUrl}?primaryCategoryId=${event.primaruCategoryId}&secondaryCategoryId=${event.secondaryCategoryId}",
//         zipFilePath,
//         options: Options(
//           headers: {
//             "Authorization": getData.token,
//             "Content-Type": "application/json",
//           },
//         ),
//         onReceiveProgress: (received, total) {
//           if (total != -1) {
//             final percentage =
//                 "${(received / total * 100).toStringAsFixed(0)}%";
//             log(percentage);
//             if (currentState is ContentControllerDownloadLoadingState) {
//               emit(currentState.copyWith(percentage: percentage));
//             }
//           }
//         },
//       );
//       log('Extracting zip file...');
//       final file = File(zipFilePath);

//       emit(ContentControllerExtractLoadingState(file: file));
//       final bytes = await file.readAsBytes();
//       final archive = ZipDecoder().decodeBytes(bytes);

//       final extractPath = await _getPath(
//         extractedContentPath,
//         event.primaruCategoryId,
//         event.secondaryCategoryId,
//       );
//       // final extractPath =
//       //     '${dir.path}/$extractedContentPath/${event.primaruCategoryId}/${event.secondaryCategoryId}';

//       for (final file in archive) {
//         final filename = path.join(extractPath, file.name);

//         if (file.isFile) {
//           final outFile = File(filename);
//           await outFile.create(recursive: true);
//           await outFile.writeAsBytes(file.content as List<int>);
//         } else {
//           await Directory(filename).create(recursive: true);
//         }
//       }
//       log('--Extracting Completed--');
//       final jsonData = await _parseContentJson(extractPath);
//       emit(ContentControllerDownloadAndExtractSuccessState(jsonData: jsonData));
//     } catch (e) {
//       log("Error -> ${e.toString()}");
//     }
//   }

//   Future<void> _loadContents(
//     LoadContent event,
//     Emitter<ContentControllerState> emit,
//   ) async {
//     if (await _isContentAvailableLocally(
//       event.primaruCategoryId,
//       event.secondaryCategoryId,
//     )) {
//       // Load from local storage
//       log("Loading From Local");
//       final jsonData = await _loadContentFromLocal(
//         event.primaruCategoryId,
//         event.secondaryCategoryId,
//       );
//       emit(ContentControllerDownloadAndExtractSuccessState(jsonData: jsonData));
//     } else {
//       log("Loading From Server");
//       // Download and extract as before
//       add(
//         DownloadAndExtractContentZip(
//           primaruCategoryId: event.primaruCategoryId,
//           secondaryCategoryId: event.secondaryCategoryId,
//         ),
//       );
//     }
//   }

//   Future<List<ContentJsonModel>> _parseContentJson(String extractPath) async {
//     log('Converting json file to Model...');
//     final file = File('$extractPath/contents.json');
//     final jsonString = await file.readAsString();
//     // log(jsonString);
//     final data = jsonDecode(jsonString) as List;
//     return data
//         .map((e) => ContentJsonModel.fromJson(e))
//         .toList(); // returns List of content items
//   }

//   Future<bool> _isContentAvailableLocally(
//     String primaruCategoryId,
//     String secondaryCategoryId,
//   ) async {
//     final path = await _getPath(
//       extractedContentPath,
//       primaruCategoryId,
//       secondaryCategoryId,
//     );

//     final extractedFolder = Directory(path);

//     return extractedFolder.existsSync(); // true if folder exists
//   }

//   Future<List<ContentJsonModel>> _loadContentFromLocal(
//     String primaruCategoryId,
//     String secondaryCategoryId,
//   ) async {
//     final path = await _getPath(
//       extractedContentPath,
//       primaruCategoryId,
//       secondaryCategoryId,
//     );
//     return await _parseContentJson(path);
//   }

//   Future<String> _getPath(
//     String fileName,
//     String primaryCategoryId,
//     String secondaryCategoryId,
//   ) async {
//     final dir = await getApplicationDocumentsDirectory();
//     return '${dir.path}/$primaryCategoryId/$secondaryCategoryId/$fileName';
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/utils/permission_handler.dart';
import 'package:bashasagar/features/session/data/models/content_json_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'content_controller_event.dart';
part 'content_controller_state.dart';

class ContentControllerBloc
    extends Bloc<ContentControllerEvent, ContentControllerState> {
  ContentControllerBloc() : super(ContentControllerInitialState()) {
    on<DownloadContentById>(_downloadContentById);
    on<LoadContentById>(_loadContentById);
    on<OnChangeContent>(_onChangeIndex);
    // on<CheckContentAlreadyDowloadedById>(_checkAlreadyDowloadedOrNot);
  }

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConst.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  static const zipPath = "app_content.zip";
  static const extractedContentPath = "app_contents";

  /// Download content zip for specific secondary category and extract
  Future<void> _downloadContentById(
    DownloadContentById event,
    Emitter<ContentControllerState> emit,
  ) async {
    try {
      if (!await AppPermissions.requestStoragePermission()) {
        emit(
          ContentDownloadErrorState(
            secondaryCategoryId: event.secondaryCategoryId,
            error: 'Storage permission denied',
          ),
        );
        return;
      }
      emit(
        ContentDownloadProgressState(
          secondaryCategoryId: event.secondaryCategoryId,
          progress: "0%",
        ),
      );
      final getData = await CurrentUserPref.getUserData;

      final zipFilePath = await getPath(
        zipPath,
        event.primaryCategoryId,
        event.secondaryCategoryId,
      );
      final extractPath = await getPath(
        extractedContentPath,
        event.primaryCategoryId,
        event.secondaryCategoryId,
      );

      // Download zip
      log('Downloading zip for ${event.secondaryCategoryId}...');
      await dio.download(
        "${ApiConst.contentUrl}?primaryCategoryId=${event.primaryCategoryId}&secondaryCategoryId=${event.secondaryCategoryId}",
        zipFilePath,
        options: Options(
          headers: {
            "Authorization": getData.token,
            "Content-Type": "application/json",
          },
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final percentage =
                "${(received / total * 100).toStringAsFixed(0)}%";
            emit(
              ContentDownloadProgressState(
                secondaryCategoryId: event.secondaryCategoryId,
                progress: percentage,
              ),
            );
          }
        },
      );

      // Extract zip
      log('Extracting zip for ${event.secondaryCategoryId}...');
      final file = File(zipFilePath);
      final bytes = await file.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        String fileName;
        if (file.name.endsWith(".json")) {
          fileName = path.join(extractPath, file.name);
        } else {
          fileName = path.join("$extractPath/uploads", file.name);
        }

        log(fileName);
        if (file.isFile) {
          final outFile = File(fileName);
          await outFile.create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
          // log("isFile");
          // log(filename);
        } else {
          // log("isNotFile");
          // log(filename);
          await Directory(fileName).create(recursive: true);
        }
      }

      log('Extraction completed for ${event.secondaryCategoryId}.');

      // Parse contents.json
      final jsonData = await _parseContentJson(extractPath);
      log("Done ${event.secondaryCategoryId}.");
      emit(
        ContentLoadFromLocalState(
          currentFile: jsonData.first,
          currentIndex: 0,
          secondaryCategoryId: event.secondaryCategoryId,
          jsonData: jsonData,
        ),
      );
    } catch (e) {
      log("Error downloading ${event.secondaryCategoryId}: ${e.toString()}");
      emit(
        ContentDownloadErrorState(
          secondaryCategoryId: event.secondaryCategoryId,
          error: e.toString(),
        ),
      );
    }
  }

  /// Load content from local if exists, else emit error state
  Future<void> _loadContentById(
    LoadContentById event,
    Emitter<ContentControllerState> emit,
  ) async {
    // final extractedFolder = Directory(extractPath);

    // if (extractedFolder.existsSync()) {
    final isExist = await checkAlreadyDowloadedOrNot(
      event.primaryCategoryId,
      event.secondaryCategoryId,
    );
    if (isExist) {
      final extractPath = await getPath(
        extractedContentPath,
        event.primaryCategoryId,
        event.secondaryCategoryId,
      );
      log("Loading content from local for ${event.secondaryCategoryId}");
      final jsonData = await _parseContentJson(extractPath);
      log("Done ${event.secondaryCategoryId}.");
      emit(
        ContentLoadFromLocalState(
          currentFile: jsonData.first,
          currentIndex: 0,
          secondaryCategoryId: event.secondaryCategoryId,
          jsonData: jsonData,
        ),
      );
    } else {
      add(
        DownloadContentById(
          primaryCategoryId: event.primaryCategoryId,
          secondaryCategoryId: event.secondaryCategoryId,
        ),
      );
    }
  }

  Future<void> _onChangeIndex(
    OnChangeContent event,
    Emitter<ContentControllerState> emit,
  ) async {
    final currenState = state;
    if (currenState is ContentLoadFromLocalState) {
      if (event.isForward) {
        if (currenState.jsonData.length - 1 == currenState.currentIndex) {
          log("Complted...");
        } else {
          int newIndex = currenState.currentIndex! + 1;

          emit(currenState.copyWith(currenState.jsonData[newIndex], newIndex));
        }
      } else {
        if (0 == currenState.currentIndex) {
          log("No more...");
        } else {
          int newIndex = currenState.currentIndex! - 1;

          emit(currenState.copyWith(currenState.jsonData[newIndex], newIndex));
        }
      }
    }
  }

  Future<bool> checkAlreadyDowloadedOrNot(
    // CheckContentAlreadyDowloadedById event,
    // Emitter<ContentControllerState> emit,
    String primaryCategoryId,
    String secondaryCategoryId,
  ) async {
    final path = await getPath(
      extractedContentPath,
      primaryCategoryId,
      secondaryCategoryId,
    );

    final extractedFolder = Directory(path);

    if (extractedFolder.existsSync()) {
      return true;
    } else {
      return false;
      // emit(ContentControllerState(isExist: false));
    }
  }

  /// Parse contents.json into model list
  Future<List<ContentJsonModel>> _parseContentJson(String extractPath) async {
    log('Parsing contents.json at $extractPath');
    final file = File('$extractPath/contents.json');
    final jsonString = await file.readAsString();
    final data = jsonDecode(jsonString) as List;
    return data.map((e) => ContentJsonModel.fromJson(e)).toList();
  }

  static Future<String> getPath(
    String fileName,
    String primaryCategoryId,
    String secondaryCategoryId,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$primaryCategoryId/$secondaryCategoryId/$fileName';
  }
}
