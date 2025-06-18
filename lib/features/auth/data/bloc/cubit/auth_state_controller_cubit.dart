import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state_controller_state.dart';

class AuthStateControllerCubit extends Cubit<AuthStateControllerState> {
  AuthStateControllerCubit()
    : super(AuthStateControllerInitial(AuthTab.LOGIN));

  void onChangeAuthTab(AuthTab authTab) {
    emit(AuthStateControllerInitial(authTab));
  }
}
