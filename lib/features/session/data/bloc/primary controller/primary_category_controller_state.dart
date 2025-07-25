part of 'primary_category_controller_cubit.dart';

@immutable
sealed class PrimaryCategoryControllerState {}

final class PrimaryCategoryControllerInitialState
    extends PrimaryCategoryControllerState {}

final class PrimaryCategoryControllerErrorState
    extends PrimaryCategoryControllerState {
  final String error;

  PrimaryCategoryControllerErrorState({required this.error});
}

final class PrimaryCategoryControllerLoadingState
    extends PrimaryCategoryControllerState {}

final class PrimaryCategoryControllerSuccessState
    extends PrimaryCategoryControllerState {
  final List<PrimaryCategoryModel> primaryCategories;
  final int? currentIndex;

  PrimaryCategoryControllerSuccessState({
    required this.primaryCategories,
    this.currentIndex,
  });

  PrimaryCategoryControllerSuccessState copyWith({
    List<PrimaryCategoryModel>? primaryCategories,
    int? currentIndex,
  }) {
    return PrimaryCategoryControllerSuccessState(
      primaryCategories: primaryCategories ?? this.primaryCategories,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
