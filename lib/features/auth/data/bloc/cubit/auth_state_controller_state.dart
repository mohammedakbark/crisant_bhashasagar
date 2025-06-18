part of 'auth_state_controller_cubit.dart';

@immutable
sealed class AuthStateControllerState {
  final AuthTab authTab;

  AuthStateControllerState({required this.authTab});
}

final class AuthStateControllerInitial
    extends AuthStateControllerState {
  AuthStateControllerInitial(AuthTab currentAuthTab)
    : super(authTab: currentAuthTab);
}
