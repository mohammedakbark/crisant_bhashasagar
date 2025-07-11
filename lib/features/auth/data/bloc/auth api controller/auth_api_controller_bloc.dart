import 'dart:async';
import 'dart:developer';

import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/models/current_user_model.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:bashasagar/features/auth/data/repo/login_repo.dart';
import 'package:bashasagar/features/auth/data/repo/register_resend_otp_repo.dart';
import 'package:bashasagar/features/auth/data/repo/register_verify_otp_repo.dart';
import 'package:bashasagar/features/auth/data/repo/registration_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

part 'auth_api_controller_event.dart';
part 'auth_api_controller_state.dart';

class AuthApiControllerBloc
    extends Bloc<AuthApiControllerEvent, AuthApiControllerState> {
  AuthApiControllerBloc() : super(AuthApiControllerInitialState()) {
    on<OnLogin>(_onLogin);
    on<OnRegister>(_onRegister);
    on<OnResendOTP>(_onRegResendOTP);
    on<OnVerifyOTP>(_onRegVerifyOTP);
    on<OnForgetPassword>(_onForgetPassword);
  }

  Future<void> _onLogin(
    OnLogin event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await LoginRepo.onLogin(
      mobileNumber: event.mobileNumber,
      password: event.password,
      uiLangId: null,
    );

    if (response.isError) {
      await _errorDisposer(emit, response.data.toString());
    } else {
      final data = response.data as Map<String, dynamic>;
      emit(AuthApiControllerSuccessState(previouseResponse: data));
      await CurrentUserPref.setUserData(
        CurrentUserModel(
          token: data['token'],
          appLang: null,
          mobile: event.mobileNumber,
          password: event.password,
        ),
      );
      if (event.context.mounted) {
        event.context.go(routeScreen);
      }
    }
  }

  Future<void> _onRegister(
    OnRegister event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await RegistrationRepo.onRegister(
      confirmPassword: event.confirmPassword,
      name: event.customerName,
      mobileNumber: event.mobileNumber,
      password: event.password,
      uiLangId: null,
    );

    if (response.isError) {
      await _errorDisposer(emit, response.data.toString());
    } else {
      final data = response.data as Map<String, dynamic>;
      emit(AuthApiControllerSuccessState(previouseResponse: data));
      if (event.context.mounted) {
        event.context.read<AuthStateControllerCubit>().onChangeAuthTab(
          AuthTab.VERIFYOTP,
          params: {"customerId": data['customerId']},
        );
        event.context.read<AuthStateControllerCubit>().setTimer();
      }
    }
  }

  Future<void> _onRegVerifyOTP(
    OnVerifyOTP event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    log("Customer Id : ${event.customerId}");
    emit(AuthApiControllerLoadingState());
    final response = await RegisterVerifyOtpRepo.onVerifyOTP(
      customerId: event.customerId,
      otp: event.otp,
      uiLangId: null,
    );

    if (response.isError) {
      _errorDisposer(emit, response.data.toString());
    } else {
      final data = response.data as Map<String, dynamic>;
      emit(AuthApiControllerSuccessState(previouseResponse: data));
      if (event.context.mounted) {
        event.context.go(
          authSuccessScreen,
          extra: {
            "successTitle": "SIGN UP SUCCESSFULLY",
            "successMessage": "Your account has been created successfully.",
            "buttonTitle": "LOGIN",
            "nextAuthTab": AuthTab.LOGIN,
            // "nextScreen":authScreen
          },
        );
      }
    }
  }

  Future<void> _onRegResendOTP(
    OnResendOTP event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await RegisterResendOtpRepo.onResendOTP(
      customerId: event.customerId,
      uiLangId: null,
    );

    if (response.isError) {
      _errorDisposer(emit, response.data.toString());
    } else {
      if (event.context.mounted) {
        event.context.read<AuthStateControllerCubit>().setTimer();
      }
      emit(AuthApiControllerSuccessState(previouseResponse: {}));
    }
  }

  Future<void> _onForgetPassword(
    OnForgetPassword event,
    Emitter<AuthApiControllerState> emit,
  ) async {}

  Future<void> _errorDisposer(
    Emitter<AuthApiControllerState> emit,
    String message,
  ) async {
    try {
      emit(AuthApiControllerErrorState(error: message));
      await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
        emit(AuthApiControllerInitialState());
      });
    } catch (e) {
      emit(AuthApiControllerInitialState());
    }
  }
}
