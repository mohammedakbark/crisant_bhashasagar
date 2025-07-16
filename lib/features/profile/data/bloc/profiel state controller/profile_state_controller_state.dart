part of 'profile_state_controller_cubit.dart';

@immutable
sealed class ProfileStateControllerState {}

final class ProfileStateControllerInitial extends ProfileStateControllerState {}

final class ProfileStateControllerUpdateLoadingState
    extends ProfileStateControllerState {}
