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

  PrimaryCategoryControllerSuccessState({required this.primaryCategories});
}
