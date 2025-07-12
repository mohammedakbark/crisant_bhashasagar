part of 'auth_api_controller_bloc.dart';

@immutable
sealed class AuthApiControllerState {
  final bool enableResetButton;

  AuthApiControllerState({this.enableResetButton = false});
}

final class AuthApiControllerInitialState extends AuthApiControllerState {
  AuthApiControllerInitialState({super.enableResetButton});
}

final class AuthApiControllerErrorState extends AuthApiControllerState {
  final String error;

  AuthApiControllerErrorState({required this.error, super.enableResetButton});
}

final class AuthApiControllerSuccessState extends AuthApiControllerState {
  final Map<String, dynamic> previouseResponse;

  AuthApiControllerSuccessState({
    required this.previouseResponse,
    super.enableResetButton = false,
  });
  AuthApiControllerSuccessState copyWith({
    Map<String, dynamic>? previouseResponse,
    bool? enableResetButton,
  }) {
    return AuthApiControllerSuccessState(
      previouseResponse: previouseResponse ?? this.previouseResponse,
      enableResetButton: enableResetButton ?? this.enableResetButton,
    );
  }
}

final class AuthApiControllerLoadingState extends AuthApiControllerState {
  AuthApiControllerLoadingState({super.enableResetButton});
}

final class AuthApiFetchProfileState extends AuthApiControllerState {
  final ProfileModel profileModel;

  AuthApiFetchProfileState({
    super.enableResetButton,
    required this.profileModel,
  });
}
