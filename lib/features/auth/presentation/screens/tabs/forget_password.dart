import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_response_text.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/core/const/img_const.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/theme/app_theme.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/core/utils/validators.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:solar_icons/solar_icons.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _mobileNumberController = TextEditingController();

  final _otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initUi();
    super.initState();
  }

  bool initializingUI = true;
  late GetUiLanguage getUilang;

  void initUi() async {
    getUilang = await GetUiLanguage.create("FORGOTPWD");
    initializingUI = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: ResponsiveHelper.hp * .05,
          left: 10,
          right: 10,
          child: SafeArea(child: Image.asset(ImgConst.login)),
        ),
        Positioned(
          bottom: 0,
          child:
              initializingUI
                  ? AppLoading()
                  : FadeIn(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      width: ResponsiveHelper.wp,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ResponsiveHelper.borderRadiusLarge,
                          ),
                          topRight: Radius.circular(
                            ResponsiveHelper.borderRadiusLarge,
                          ),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: AppMargin(
                          child: BlocBuilder<
                            AuthApiControllerBloc,
                            AuthApiControllerState
                          >(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  Text(
                                    getUilang
                                        .uiText(placeHolder: "FGP001")
                                        .toUpperCase(),
                                    style: AppStyle.mediumStyle(
                                      fontSize: ResponsiveHelper.fontLarge,
                                    ),
                                  ),
                                  AppSpacer(hp: .03),
                    
                                  CustomeTextField(
                                    isReadOnly: state.enableResetButton,
                                    keyboardType: TextInputType.number,
                                    prefix: Icon(SolarIconsOutline.phone),
                                    lebelText: getUilang.uiText(
                                      placeHolder: "FGP002",
                                    ),
                                    controller: _mobileNumberController,
                                    validator: AppValidator.mobileNumberValidator,
                                  ),
                                  AppSpacer(hp: .01),
                    
                                  TextButton(
                                    onPressed:
                                        state.enableResetButton
                                            ? null
                                            : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<AuthApiControllerBloc>()
                                                    .add(
                                                      OnForgetPassword(
                                                        customerMobile:
                                                            _mobileNumberController
                                                                .text
                                                                .trim(),
                                                        context: context,
                                                      ),
                                                    );
                                              }
                                            },
                                    child: Text(
                                      getUilang.uiText(placeHolder: "FGP003"),
                                      style: AppStyle.boldStyle(
                                        color:
                                            state.enableResetButton
                                                ? AppColors.kGrey
                                                : AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                    
                                  AppSpacer(hp: .01),
                    
                                  SizedBox(
                                    width: ResponsiveHelper.wp * .85,
                                    child: Pinput(
                                      validator:
                                          !state.enableResetButton
                                              ? null
                                              : (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter the OTP";
                                                }
                                                return null;
                                              },
                                      controller: _otpController,
                                      length: 6,
                                      enabled: state.enableResetButton,
                                      cursor: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.kPrimaryColor,
                                          borderRadius: BorderRadius.circular(
                                            ResponsiveHelper.borderRadiusLarge,
                                          ),
                                        ),
                    
                                        width: ResponsiveHelper.wp * .01,
                                        height: ResponsiveHelper.hp * .03,
                                      ),
                                      // showCursor: false,
                                      errorPinTheme: AppTheme.pinTheme(
                                        color: AppColors.kRed,
                                      ),
                                      followingPinTheme: AppTheme.pinTheme(),
                                      disabledPinTheme: AppTheme.pinTheme(
                                        color: AppColors.kGrey.withAlpha(60),
                                      ),
                                      defaultPinTheme: AppTheme.pinTheme(),
                                      focusedPinTheme: AppTheme.pinTheme(
                                        color: AppColors.kPrimaryColor,
                                      ),
                                      submittedPinTheme: AppTheme.pinTheme(),
                                    ),
                                  ),
                                  AppSpacer(hp: .01),
                    
                                  BlocBuilder<
                                    AuthStateControllerCubit,
                                    AuthStateControllerState
                                  >(
                                    builder: (context, state2) {
                                      return state2.timer == null
                                          ? TextButton(
                                            onPressed:
                                                !state.enableResetButton
                                                    ? null
                                                    : () {
                                                      final params =
                                                          context
                                                                  .read<
                                                                    AuthStateControllerCubit
                                                                  >()
                                                                  .state
                                                                  .params
                                                              as Map<
                                                                String,
                                                                dynamic
                                                              >?;
                                                      if (params != null) {
                                                        context
                                                            .read<
                                                              AuthApiControllerBloc
                                                            >()
                                                            .add(
                                                              OnForgetResendOTP(
                                                                customerId:
                                                                    params['customerId'],
                                                                context: context,
                                                              ),
                                                            );
                                                      }
                                                    },
                                            child: Text(
                                              getUilang.uiText(
                                                placeHolder: "FGP004",
                                              ),
                                              style: AppStyle.normalStyle(
                                                color:
                                                    state.enableResetButton
                                                        ? AppColors.kPrimaryColor
                                                        : AppColors.kGrey,
                                              ),
                                            ),
                                          )
                                          : Text(
                                            "wait ${state2.timer} seconds",
                                            style: AppStyle.smallStyle(
                                              color: AppColors.kPrimaryColor,
                                            ),
                                          );
                                    },
                                  ),
                    
                                  AppSpacer(hp: .01),
                    
                                  BlocBuilder<
                                    AuthApiControllerBloc,
                                    AuthApiControllerState
                                  >(
                                    builder: (context, state) {
                                      if (state is AuthApiControllerErrorState) {
                                        return AppResponseText(
                                          message: state.error,
                                        );
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                  AppSpacer(hp: .01),
                    
                                  AppCustomButton(
                                    title: getUilang.uiText(
                                      placeHolder: "FGP005",
                                    ),
                                    onTap:
                                        !state.enableResetButton
                                            ? null
                                            : () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final params =
                                                    context
                                                            .read<
                                                              AuthStateControllerCubit
                                                            >()
                                                            .state
                                                            .params
                                                        as Map<String, dynamic>?;
                                                if (params != null) {
                                                  context
                                                      .read<
                                                        AuthApiControllerBloc
                                                      >()
                                                      .add(
                                                        OnForgetVerifyOTP(
                                                          customerId:
                                                              params['customerId'],
                                                          otp:
                                                              _otpController.text
                                                                  .trim(),
                                                          context: context,
                                                        ),
                                                      );
                                                }
                                              }
                                              // context
                                              //     .read<AuthStateControllerCubit>()
                                              //     .onChangeAuthTab(AuthTab.RESETPASSWORD);
                                            },
                                  ),
                                  AppSpacer(hp: .01),
                                  if (state is AuthApiControllerLoadingState)
                                    AppLoading(),
                                  AppSpacer(hp: .01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        getUilang.uiText(placeHolder: "FGP006"),
                                        style: AppStyle.normalStyle(),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<AuthStateControllerCubit>()
                                              .onChangeAuthTab(AuthTab.LOGIN);
                                        },
                                        child: Text(
                                          getUilang.uiText(placeHolder: "FGP007"),
                                          style: AppStyle.boldStyle(
                                            color: AppColors.kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}
