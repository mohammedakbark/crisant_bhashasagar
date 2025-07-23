import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bashasagar/core/utils/intl_c.dart';
import 'package:bashasagar/core/utils/show_messages.dart';
import 'package:bashasagar/features/session/data/bloc/content%20controller/content_controller_bloc.dart';
import 'package:bashasagar/features/session/data/models/content_json_model.dart';
import 'package:bashasagar/features/session/data/repo/mark_content_progress_repo.dart';
import 'package:bashasagar/features/session/data/repo/transliterate_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'content_state_controller_event.dart';
part 'content_state_controller_state.dart';

class ContentStateControllerBloc
    extends Bloc<ContentStateControllerEvent, ContentStateControllerState> {
  AudioPlayer player = AudioPlayer();
  StreamSubscription<ProcessingState>? playerSubscription;
  ContentStateControllerBloc() : super(ContentStateControllerInitial()) {
    on<LoadContentById>(_loadContentById);
    on<OnChangeContent>(_onChangeIndex);
    on<TransliterateContent>(_onTransliterate);
    on<InitPlayer>(_initPlayer);
    on<AudioCompleted>(_audioCompleted);
    on<PlayAudio>(_playAudio);
    on<MarkCustomerProgress>(_markCustomerprogresss);
  }

  // Load content from local if exists, else emit error state
  Future<void> _loadContentById(
    LoadContentById event,
    Emitter<ContentStateControllerState> emit,
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
            add(InitPlayer());

      add(
        TransliterateContent(
          primaryCategoryId: event.primaryCategoryId,
          tergetLangugae: "Devanagari",
        ),
      );

      // add(
      //   PlayAudio(
      //     primaryCategoryId: event.primaryCategoryId,
      //     secondaryCategoryId: event.secondaryCategoryId,
      //   ),
      // );
    } else {
      // add(
      //   DownloadContentById(
      //     primaryCategoryId: event.primaryCategoryId,
      //     secondaryCategoryId: event.secondaryCategoryId,
      //   ),
      // );
    }
  }

  Future<void> _onTransliterate(
    TransliterateContent event,
    Emitter<ContentStateControllerState> emit,
  ) async {
    final currentState = state;
    if (currentState is ContentLoadFromLocalState) {
      emit(currentState.copyWith(isTransliterating: true));
      final response = await TransliterateRepo.onTransliterate(
        event.tergetLangugae,
        currentState.currentFile.content,
      );

      emit(
        currentState.copyWith(
          selectedLangToTransiliterate: {
            "title": event.tergetLangugae,
            "value": event.tergetLangugae,
          },
          isTransliterating: false,
          tranlatedString: response.data.toString(),
        ),
      );

      // Neew
      add(
        PlayAudio(
          primaryCategoryId: event.primaryCategoryId,
          secondaryCategoryId: currentState.secondaryCategoryId,
        ),
      );
    }
  }

  //-----------

  Future<void> _onChangeIndex(
    OnChangeContent event,
    Emitter<ContentStateControllerState> emit,
  ) async {
    final currentState = state;
    if (currentState is ContentLoadFromLocalState) {
      int newIndex =
          event.isForward
              ? currentState.currentIndex! + 1
              : currentState.currentIndex! - 1;

      // Check bounds
      if (newIndex < 0 || newIndex >= currentState.jsonData.length) {
        log("No more content in this direction...");
        emit(currentState.copyWith(isTransliterating: false));
        return;
      }

      emit(
        currentState.copyWith(
          isTransliterating: true,
          currentFile: currentState.jsonData[newIndex],
          currentIndex: newIndex,
        ),
      );
      // MARK CUSTOMER PROGRESS

      if (newIndex + 1 == currentState.jsonData.length) {
        add(
          MarkCustomerProgress(
            secondaryCategoryId: event.primaryCategoryId,
            dateTime: IntlC.convertTOApiDateTime(DateTime.now()),
          ),
        );
      }

      add(AudioCompleted());

      if (currentState.selectedLangToTransiliterate != null) {
        add(
          TransliterateContent(
            primaryCategoryId: event.primaryCategoryId,
            tergetLangugae: currentState.selectedLangToTransiliterate!['value'],
          ),
        );
      } else {
        add(
          PlayAudio(
            primaryCategoryId: event.primaryCategoryId,
            secondaryCategoryId: event.secondaryCategoryId,
          ),
        );
      }
    }
  }

  ///
  ///
  ///
  ///.  AUDIO PLAYER CONTROLLER
  ///
  ///
  Future<void> _audioCompleted(
    AudioCompleted event,
    Emitter<ContentStateControllerState> emit,
  ) async {
    final currentState = state;
    if (currentState is ContentLoadFromLocalState) {
      await player.stop();
      emit(currentState.copyWith(isAudioPlaying: false));
    }
  }

  Future<void> _initPlayer(
    InitPlayer event,
    Emitter<ContentStateControllerState> emit,
  ) async {
    final currentState = state;
    if (currentState is ContentLoadFromLocalState) {
      await playerSubscription?.cancel();
      log("PLAYER INITIALIZED...");
      playerSubscription = player.processingStateStream.listen((state) {
        if (state == ProcessingState.completed) {
          add(AudioCompleted());
        }
      });
    }
  }

  Future<void> _playAudio(
    PlayAudio event,
    Emitter<ContentStateControllerState> emit,
  ) async {
    final currentState = state;
    if (currentState is ContentLoadFromLocalState) {
      try {
        final paths = await getPath(
          extractedContentPath,
          event.primaryCategoryId,
          event.secondaryCategoryId,
        );
        await player.setFilePath(
          path.join(paths, currentState.currentFile.contentAudio),
        );

        if (player.playing) {
          player.stop();
          emit(currentState.copyWith(isAudioPlaying: false));
        } else {
          player.play();
          emit(currentState.copyWith(isAudioPlaying: true));
        }
      } catch (e, st) {
        emit(currentState.copyWith(isAudioPlaying: false));
        showToast("Audio is missing", isError: true);
        // showToast("$e : ${st.toString()}", isError: true);

        log("Audio play error: $e");
      }
    }
  }

  //--------------A P I--------

  Future<void> _markCustomerprogresss(
    MarkCustomerProgress event,
    Emitter<ContentStateControllerState> emit,
  ) async {
    log("last one");
    final resposne = await MarkContentProgressRepo.onMarlContentProgress(
      event.secondaryCategoryId,
      event.dateTime,
    );
    if (resposne.isError) {
      log("Marking progress failed -> ${resposne.data}");
    } else {
      log(resposne.data.toString());
    }
  }

  //----

  Future<bool> checkAlreadyDowloadedOrNot(
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
    }
  }

  @override
  Future<void> close() {
    playerSubscription?.cancel();
    return super.close();
  }

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
    return '${dir.path}/$fileName/$primaryCategoryId/$secondaryCategoryId';
  }
}
