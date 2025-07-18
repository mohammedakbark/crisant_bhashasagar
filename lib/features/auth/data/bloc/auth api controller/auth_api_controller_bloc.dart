import 'dart:async';
import 'dart:developer';

import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/models/current_user_model.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:bashasagar/features/auth/data/repo/foreget_password_repo.dart';
import 'package:bashasagar/features/auth/data/repo/foreget_password_verify_otp_repo.dart';
import 'package:bashasagar/features/auth/data/repo/forget_password_resend_otp_repo.dart';
import 'package:bashasagar/features/auth/data/repo/login_repo.dart';
import 'package:bashasagar/features/auth/data/repo/register_resend_otp_repo.dart';
import 'package:bashasagar/features/auth/data/repo/register_verify_otp_repo.dart';
import 'package:bashasagar/features/auth/data/repo/registration_repo.dart';
import 'package:bashasagar/features/auth/data/repo/reset_password_repo.dart';
import 'package:bashasagar/features/profile/data/models/profile_model.dart';
import 'package:bashasagar/features/profile/data/repo/profile_repo.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
    on<OnForgetResendOTP>(_onForgetResendOTP);
    on<OnForgetVerifyOTP>(_onForgetVerifyOTP);
    on<OnResetPassword>(_onResetPasssword);

    on<OnGetProfileInfo>(_getProfileInfo);
  }

  // LOGIN
  Future<void> _onLogin(
    OnLogin event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await LoginRepo.onLogin(
      mobileNumber: event.mobileNumber,
      password: event.password,
    );
    if (response.isError) {
      await _errorDisposer(emit, response.data.toString());
    } else {
      final data = response.data as Map<String, dynamic>;
      emit(AuthApiControllerSuccessState(previouseResponse: data));
     

      await CurrentUserPref.setUserData(
        CurrentUserModel(
          token: data['token'],
          mobile: event.mobileNumber,
          password: event.password,
        ),
      );

       add(OnGetProfileInfo(storeData: true));

      if (event.context.mounted) {
        await event.context
            .read<UiLanguageControllerCubit>()
            .updateUiLanguageInServer();
      }
      if (event.context.mounted) {
        event.context.go(routeScreen);
      }
    }
  }

  // REGISTATION
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
    emit(AuthApiControllerLoadingState());
    final response = await RegisterVerifyOtpRepo.onVerifyOTP(
      customerId: event.customerId,
      otp: event.otp,
    );

    if (response.isError) {
      await _errorDisposer(emit, response.data.toString());
    } else {
      final data = response.data as Map<String, dynamic>;
      emit(AuthApiControllerSuccessState(previouseResponse: data));
      final getUilang = await GetUiLanguage.create("REGISTERSUCCESS");

      if (event.context.mounted) {
        event.context.go(
          authSuccessScreen,
          extra: {
            "successTitle":
                getUilang.uiText(placeHolder: "REGS001").toUpperCase(),
            "successMessage": getUilang.uiText(placeHolder: "REGS002"),
            "buttonTitle":getUilang.uiText(placeHolder: "REGS003"),
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
    );

    if (response.isError) {
      await _errorDisposer(emit, response.data.toString());
    } else {
      if (event.context.mounted) {
        event.context.read<AuthStateControllerCubit>().setTimer();
      }
      emit(AuthApiControllerSuccessState(previouseResponse: {}));
    }
  }

  //  FORGET PASSWORD
  Future<void> _onForgetPassword(
    OnForgetPassword event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await ForegetPasswordRepo.onForgetPassword(
      mobileNumber: event.customerMobile,
    );

    if (response.isError) {
      await _errorDisposer(emit, response.data.toString());
    } else {
      final data = response.data as Map<String, dynamic>;
      emit(
        AuthApiControllerSuccessState(
          enableResetButton: true,
          previouseResponse: {},
        ),
      );
      if (event.context.mounted) {
        event.context.read<AuthStateControllerCubit>().onChangeAuthTab(
          AuthTab.FORGETPASSWORD,
          params: {"customerId": data['customerId'].toString()},
        );
        event.context.read<AuthStateControllerCubit>().setTimer();
      }
    }
  }

  Future<void> _onForgetVerifyOTP(
    OnForgetVerifyOTP event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await ForegetPasswordVerifyOtpRepo.onVerifyOTP(
      customerId: event.customerId,
      otp: event.otp,
    );

    if (response.isError) {
      await _errorDisposer(
        emit,
        response.data.toString(),
        isEnableButton: true,
      );
    } else {
      emit(
        AuthApiControllerSuccessState(
          previouseResponse: {},
          enableResetButton: false,
        ),
      );
      if (event.context.mounted) {
        event.context.read<AuthStateControllerCubit>().onChangeAuthTab(
          AuthTab.RESETPASSWORD,
          params: {"customerId": event.customerId},
        );
      }
    }
  }

  Future<void> _onForgetResendOTP(
    OnForgetResendOTP event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await ForgetPasswordResendOtpRepo.onResendOTP(
      customerId: event.customerId,
    );

    if (response.isError) {
      await _errorDisposer(
        emit,
        response.data.toString(),
        isEnableButton: true,
      );
    } else {
      emit(
        AuthApiControllerSuccessState(
          previouseResponse: {},
          enableResetButton: true,
        ),
      );
      if (event.context.mounted) {
        event.context.read<AuthStateControllerCubit>().setTimer();
      }
    }
  }

  Future<void> _onResetPasssword(
    OnResetPassword event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await ResetPasswordRepo.onResetPassword(
      customerId: event.customerId,
      confirmPassword: event.confirmPassword,
      password: event.password,
    );

    if (response.isError) {
      await _errorDisposer(emit, response.data.toString());
    } else {
      emit(AuthApiControllerSuccessState(previouseResponse: {}));
      final getUilang = await GetUiLanguage.create("RESETPWDSUCCESS");
      if (event.context.mounted) {
        event.context.go(
          authSuccessScreen,
          extra: {
            "successTitle": getUilang.uiText(placeHolder: "RES001"),
            "successMessage": getUilang.uiText(placeHolder: "RES002"),
            "buttonTitle": getUilang.uiText(placeHolder: "RES003"),
            "nextAuthTab": AuthTab.LOGIN,
          },
        );
      }
    }
  }

  Future<void> _errorDisposer(
    Emitter<AuthApiControllerState> emit,
    String message, {
    bool isEnableButton = false,
  }) async {
    try {
      emit(AuthApiControllerErrorState(error: message));
      await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
        emit(AuthApiControllerInitialState(enableResetButton: isEnableButton));
      });
    } catch (e) {
      emit(AuthApiControllerInitialState(enableResetButton: isEnableButton));
    }
  }

  // PROFILE
  Future<void> _getProfileInfo(
    OnGetProfileInfo event,
    Emitter<AuthApiControllerState> emit,
  ) async {
    emit(AuthApiControllerLoadingState());
    final response = await ProfileRepo.onGetProfileInfo();

    if (response.isError) {
      await _errorDisposer(emit, response.data.toString());
    } else {
      final model = response.data as ProfileModel;
      if (event.storeData) {
        await CurrentUserPref.setUserData(
          CurrentUserModel(name: model.customerName),
        );
      }
      emit(AuthApiFetchProfileState(profileModel: model));
    }
  }
}
