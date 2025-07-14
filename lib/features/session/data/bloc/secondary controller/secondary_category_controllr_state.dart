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

  SecondaryCategoryControllerSuccessState({required this.secondaryCategories});
}
