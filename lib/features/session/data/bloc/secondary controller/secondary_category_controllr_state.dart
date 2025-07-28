part of 'secondary_category_controllr_cubit.dart';

@immutable
sealed class SecondaryCategoryControllrState {}

final class SecondaryCategoryControllerInitialState
    extends SecondaryCategoryControllrState {}

final class SecondaryCategoryControllerErrorState
    extends SecondaryCategoryControllrState {
  final String error;

  SecondaryCategoryControllerErrorState({required this.error});
}

final class SecondaryCategoryControllerLoadingState
    extends SecondaryCategoryControllrState {}

final class SecondaryCategoryControllerSuccessState
    extends SecondaryCategoryControllrState {
  final List<SecondaryCategoryModel> secondaryCategories;
  final int? currentIndex;
  final List<VersionCheckDataModel> versions;

  SecondaryCategoryControllerSuccessState({
    required this.secondaryCategories,
    this.versions = const [],
    this.currentIndex,
  });

  SecondaryCategoryControllerSuccessState copyWith({
    List<SecondaryCategoryModel>? secondaryCategories,
    int? currentIndex,
    List<VersionCheckDataModel>? versions,
  }) {
    return SecondaryCategoryControllerSuccessState(
      secondaryCategories: secondaryCategories ?? this.secondaryCategories,
      currentIndex: currentIndex ?? this.currentIndex,
      versions: versions ?? this.versions,
    );
  }
}
