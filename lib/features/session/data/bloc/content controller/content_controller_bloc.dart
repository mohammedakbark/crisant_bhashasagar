import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:bashasagar/core/const/api_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/utils/show_messages.dart';
import 'package:bashasagar/features/session/data/models/content_json_model.dart';
import 'package:bashasagar/features/session/data/models/version_check_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'content_controller_event.dart';
part 'content_controller_state.dart';

const zipFile = "app_content.zip";
const extractedContentFile = "bhashasagar";
const lastUpdatedFile = "lastupdated.json";

class ContentControllerBloc
    extends Bloc<ContentControllerEvent, ContentControllerState> {
  ContentControllerBloc() : super(ContentControllerInitialState()) {
    on<DownloadContentById>(_downloadContentById);
    on<DeleteContentById>(_deletContentByIdFromLocal);
  }

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConst.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  /// Download content zip for specific secondary category and extract
  Future<void> _downloadContentById(
    DownloadContentById event,
    Emitter<ContentControllerState> emit,
  ) async {
    try {
      List<Map<String, dynamic>> lastDowloadings = [];
      final curretState = state;
      if (curretState is ContentDownloadProgressState) {
        final lastData = curretState.progressingData;
        lastDowloadings = [
          ...lastData,
          {"progress": "0%", "secondaryCategoryId": event.secondaryCategoryId},
        ];
      } else {
        lastDowloadings.add({
          "progress": "0%",
          "secondaryCategoryId": event.secondaryCategoryId,
        });
      }

      emit(ContentDownloadProgressState(progressingData: lastDowloadings));
      final getData = await CurrentUserPref.getUserData;

      final extractPath = await getPath(
        extractedContentFile,
        event.primaryCategoryId,
        event.secondaryCategoryId,
      );
      final zipFilePath = "$extractPath/$zipFile";
      final lastUpdatedDatePath = "$extractPath/$lastUpdatedFile";
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

        onReceiveProgress: (received, total) {},
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

        // log(fileName);
        if (file.isFile) {
          final outFile = File(fileName);
          await outFile.create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        } else {
          await Directory(fileName).create(recursive: true);
        }
      }

      log('Extraction completed for ${event.secondaryCategoryId}.');

      log("upating last updated date");
      final dateFile = File(lastUpdatedDatePath);
      final data = {
        'lastModified':
            event.latestModifiedDate == null
                ? DateTime.now().toString()
                : event.latestModifiedDate.toString(),
      };
      await dateFile.writeAsString(jsonEncode(data));

      getLastModified(extractPath);

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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        showToast("Connect with internet!", isError: true);
      }
      emit(
        ContentDownloadErrorState(
          secondaryCategoryId: event.secondaryCategoryId,
          error: e.toString(),
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

  Future<void> _deletContentByIdFromLocal(
    DeleteContentById event,
    Emitter<ContentControllerState> emit,
  ) async {
    final currentState = state;
    if (currentState is ContentLoadFromLocalState) {
      // final dir = await getApplicationDocumentsDirectory();
      // final folderPath =
      //     '${dir.path}/$extractedContentPath/${event.primaryCategoryId}/${event.secondaryCategoryId}';
      final folderPath = await getPath(
        extractedContentFile,
        event.primaryCategoryId,
        event.secondaryCategoryId,
      );
      log('Deleting folders ${folderPath}');
      final folder = Directory(folderPath);
      if (await folder.exists()) {
        await folder.delete(recursive: true);
        log("Deleted folder: $folderPath");

        emit(currentState.copyWith());
      } else {
        log("Folder does not exist: $folderPath");
      }
    }
  }

  static Future<void> deleteEntireContentFromBashasagar() async {
    // USERD THIS FNCTION WHILE LOGOUTING
    final dir = await getApplicationDocumentsDirectory();

    final folderPath = '${dir.path}/$extractedContentFile';
    final folder = Directory(folderPath);
    if (await folder.exists()) {
      await folder.delete(recursive: true);
      log("Deleted Entrire bashasagar content: $folderPath");
    } else {
      log("Folder does not exist: $folderPath");
    }
  }

  ///------------------------

  /// Parse contents.json into model list
  Future<List<ContentJsonModel>> _parseContentJson(String extractPath) async {
    log('Parsing contents.json at $extractPath');
    final file = File('$extractPath/contents.json');
    final jsonString = await file.readAsString();
    final data = jsonDecode(jsonString) as List;
    return data.map((e) => ContentJsonModel.fromJson(e)).toList();
  }

  static Future<Map<String, dynamic>> getLastModified(
    String extractPath,
  ) async {
    log('Parsing updatedDate.json at $extractPath');
    final file = File('$extractPath/$lastUpdatedFile');
    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final data = jsonDecode(jsonString);
      log("Date retrived $data");
      return data;
    } else {
      return {};
    }
  }

  static Future<String> getPath(
    String fileName,
    String primaryCategoryId,
    String secondaryCategoryId,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$fileName/$primaryCategoryId/$secondaryCategoryId';
  }

  // void deleteAllFolder() async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final folderPath =
  //       '${dir.path}/${event.primaryCategoryId}/${event.secondaryCategoryId}';
  //   final folder = Directory(folderPath);
  //   if (await folder.exists()) {
  //     await folder.delete(recursive: true);
  //     log("Deleted folder: $folderPath");

  //     emit(currentState.copyWith());
  //   } else {
  //     log("Folder does not exist: $folderPath");
  //   }
  // }
  // FUNCRION FOR DELETING OLD VERSION AUTOMAICALLY <WHEN THE NOTIFICATION CAME FROM THE SERVER
  void deleteTheOldVersion(
    String primaryCategoryId,
    String secondaryCategoryId,
  ) async {
    final path = await getPath(
      extractedContentFile,
      primaryCategoryId,
      secondaryCategoryId,
    );

    final folder = Directory(path);
    if (await folder.exists()) {
      await folder.delete(recursive: true);
      log("Deleted folder: $path");
    } else {
      log("Folder does not exist: $path");
    }
  }
}
