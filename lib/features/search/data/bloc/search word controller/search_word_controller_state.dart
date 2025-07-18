part of 'search_word_controller_cubit.dart';

@immutable
sealed class SearchWordControllerState {
  final Map<String, dynamic>? selectedLang;
  final String? lastquery;

  const SearchWordControllerState({this.selectedLang, this.lastquery});
}

final class SearchWordControllerInitialState extends SearchWordControllerState {
  const SearchWordControllerInitialState({super.selectedLang, super.lastquery});
}

final class SearchLoadingState extends SearchWordControllerState {
  const SearchLoadingState({super.selectedLang, super.lastquery});
}

final class SearchErrorState extends SearchWordControllerState {
  final String error;

  const SearchErrorState({
    required this.error,
    super.selectedLang,
    super.lastquery,
  });
}

final class SearchDataState extends SearchWordControllerState {
  final List<SearchWordModel> searchReslut;
  final bool isAudioPaying;
  final int? liveTileIndex;

  const SearchDataState({
    required this.searchReslut,
    super.selectedLang,
    super.lastquery,
    this.isAudioPaying = false,
    this.liveTileIndex,
  });
  SearchDataState coptyWith({
    List<SearchWordModel>? searchReslut,
    Map<String, dynamic>? selectedLang,
    String? lastquery,
    bool? isAudioPaying,
    int? liveTileIndex,
  }) {
    return SearchDataState(
      searchReslut: searchReslut ?? this.searchReslut,
      selectedLang: selectedLang ?? this.selectedLang,
      lastquery: lastquery ?? this.lastquery,
      isAudioPaying: isAudioPaying ?? this.isAudioPaying,
      liveTileIndex: liveTileIndex
    );
  }
}
