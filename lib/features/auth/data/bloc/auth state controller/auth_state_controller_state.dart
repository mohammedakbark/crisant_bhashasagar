part of 'auth_state_controller_cubit.dart';

@immutable
sealed class AuthStateControllerState {
  final AuthTab authTab;
  final Object? params;
  final int? timer;

  const AuthStateControllerState({
    required this.authTab,
    this.params,
    this.timer,
  });
}

final class AuthStateControllerInitial extends AuthStateControllerState {
  const AuthStateControllerInitial(
    AuthTab currentAuthTab,
    Object? params,
    int? timer,
  ) : super(authTab: currentAuthTab, params: params, timer: timer);

  AuthStateControllerInitial copyWith({
    AuthTab? newAuthTap,
    Object? newParams,
    int? newTimer,
  }) {
    return AuthStateControllerInitial(
      newAuthTap ?? authTab,
      newParams ?? params,
      newTimer ?? timer,
    );
  }
}
