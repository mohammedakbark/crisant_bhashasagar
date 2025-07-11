part of 'auth_api_controller_bloc.dart';

@immutable
sealed class AuthApiControllerState {}

final class AuthApiControllerInitialState extends AuthApiControllerState {}

final class AuthApiControllerErrorState extends AuthApiControllerState {
  final String error;

  AuthApiControllerErrorState({required this.error});

 
}

final class AuthApiControllerSuccessState extends AuthApiControllerState {
  final Map<String, dynamic> previouseResponse;

  AuthApiControllerSuccessState({required this.previouseResponse});
}

final class AuthApiControllerLoadingState extends AuthApiControllerState {}
