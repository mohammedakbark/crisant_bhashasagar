part of 'dashboard_controller_cubit.dart';

@immutable
sealed class DashboardControllerState {}

final class DashboardControllerInitialState extends DashboardControllerState {}

final class DashboardControllerLoadingState extends DashboardControllerState {}

final class DashboardControllerErrorState extends DashboardControllerState {
  final String error;

  DashboardControllerErrorState({required this.error});
}

final class DashboardControllerSuccessState extends DashboardControllerState {
  final List<DashboardLanguageProgressModel> languages;

  DashboardControllerSuccessState({required this.languages});
}
