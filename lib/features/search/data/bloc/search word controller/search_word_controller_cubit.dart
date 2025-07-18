import 'dart:async';
import 'dart:developer';

import 'package:bashasagar/features/search/data/models/search_word_model.dart';
import 'package:bashasagar/features/search/data/repo/search_word_Repo.dart';
import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'search_word_controller_state.dart';

class SearchWordControllerCubit extends Cubit<SearchWordControllerState> {
  AudioPlayer player = AudioPlayer();
  StreamSubscription<ProcessingState>? playerSubscription;
  SearchWordControllerCubit() : super(SearchWordControllerInitialState());

  void initScreen() async {
    await playerSubscription?.cancel();
    log("PLAYER INITIALIZED...");

    playerSubscription = player.processingStateStream.listen((
      audioState,
    ) async {
      if (audioState == ProcessingState.completed) {
        final currentState = state;
        if (currentState is SearchDataState) {
          await player.stop();
          emit(currentState.coptyWith(isAudioPaying: false));
        }
      }
    });
    emit(SearchWordControllerInitialState());
  }

  Future<void> onSearchWord(String query) async {
    final currentState = state;
    if (query.isEmpty) {
      emit(
        SearchWordControllerInitialState(
          selectedLang: currentState.selectedLang,
        ),
      );
      return;
    }
    emit(SearchWordControllerInitialState(lastquery: query));
    if (currentState.selectedLang == null) return;
    emit(
      SearchLoadingState(
        lastquery: query,
        selectedLang: currentState.selectedLang,
      ),
    );

    final respose = await SearchWordRepo.onSearchWord(
      currentState.selectedLang!['value'],
      // "ವಸ್ತು ಭಂಡಾರ",
      query,
    );

    if (respose.isError) {
      emit(
        SearchErrorState(
          error: respose.data.toString(),
          lastquery: query,
          selectedLang: currentState.selectedLang,
        ),
      );
    } else {
      emit(
        SearchDataState(
          searchReslut: respose.data as List<SearchWordModel>,
          lastquery: query,
          selectedLang: currentState.selectedLang,
        ),
      );
    }
  }

  void clearField() {
    emit(SearchWordControllerInitialState(selectedLang: state.selectedLang));
  }

  void onChangeLanguage(Map<String, dynamic> lang) async {
    final currentState = state;
    if (currentState is SearchDataState) {
      emit(currentState.coptyWith(selectedLang: lang));
      if (currentState.lastquery != null) {
        await onSearchWord(currentState.lastquery!);
      }

      return;
    } else {
      emit(
        SearchWordControllerInitialState(
          selectedLang: lang,
          lastquery: currentState.lastquery,
        ),
      );

      if (currentState.lastquery != null) {
        await onSearchWord(currentState.lastquery!);
      }
    }
  }

  Future<void> playAudio(String url, int index) async {
    final currentState = state;
    if (currentState is SearchDataState) {
      emit(currentState.coptyWith(isAudioPaying: true));
      try {
        await player.setUrl(url);
        if (player.playing) {
          player.stop();
          emit(currentState.coptyWith(isAudioPaying: false));
        } else {
          player.play();
          emit(
            currentState.coptyWith(isAudioPaying: true, liveTileIndex: index),
          );
        }
      } catch (e) {
        emit(currentState.coptyWith(isAudioPaying: false));
        log("Audio play error: $e");
      }

      // emit(currentState.coptyWith(isAudioPaying: true, liveTileIndex: index));
      // await Future.delayed(Duration(seconds: 1));
      // emit(currentState.coptyWith(isAudioPaying: false, liveTileIndex: null));
    }
  }

  @override
  Future<void> close() {
    playerSubscription?.cancel();
    return super.close();
  }
}
