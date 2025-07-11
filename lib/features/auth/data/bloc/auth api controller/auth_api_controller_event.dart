part of 'auth_api_controller_bloc.dart';

@immutable
sealed class AuthApiControllerEvent {}

class OnLogin extends AuthApiControllerEvent {
  final BuildContext context;
  final String mobileNumber;
  final String password;
  // final String? uiLangId;

  OnLogin({
    required this.context,
    required this.mobileNumber,
    required this.password,
    // required this.uiLangId,
  });
}

class OnRegister extends AuthApiControllerEvent {
  final BuildContext context;
  final String mobileNumber;
  final String password;
  final String confirmPassword;
  // final String? uiLangId;
  final String customerName;

  OnRegister({
    required this.context,
    required this.mobileNumber,
    required this.password,
    required this.confirmPassword,
    // required this.uiLangId,
    required this.customerName,
  });
}

class OnResendOTP extends AuthApiControllerEvent {
  final BuildContext context;

  // final String? uiLangId;
  final int customerId;

  OnResendOTP({
    // required this.uiLangId,
    required this.customerId,
    required this.context,
  });
}

class OnVerifyOTP extends AuthApiControllerEvent {
  final BuildContext context;

  // final String? uiLangId;
  final int customerId;
  final String otp;

  OnVerifyOTP({
    required this.context,
    // required this.uiLangId,
    required this.customerId,
    required this.otp,
  });
}

class OnForgetPassword extends AuthApiControllerEvent {}
