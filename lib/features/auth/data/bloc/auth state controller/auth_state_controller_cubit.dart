import 'dart:async';
import 'dart:developer';

import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state_controller_state.dart';

class AuthStateControllerCubit extends Cubit<AuthStateControllerState> {
  AuthStateControllerCubit()
    : super(AuthStateControllerInitial(AuthTab.LOGIN, {}, null));

  void onChangeAuthTab(AuthTab authTab, {Object? params}) {
    emit(AuthStateControllerInitial(authTab, params, null));
  }

  Timer? _timer;
  void setTimer() {
    final currentState = state;
    if (currentState is AuthStateControllerInitial) {
      int countdown = 60;

      // Emit initial timer state
      emit(currentState.copyWith(newTimer: countdown));

      // Start timer
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        countdown--;

        if (countdown <= 0) {
          timer.cancel();
          emit(currentState.copyWith(newTimer: null));
        } else {
          emit(currentState.copyWith(newTimer: countdown));
        }
      });
    }
  }
}
