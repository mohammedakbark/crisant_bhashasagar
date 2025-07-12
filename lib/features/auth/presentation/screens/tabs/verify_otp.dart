import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_response_text.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/config/language/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/theme/app_theme.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pinput/pinput.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
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
    getUilang = await GetUiLanguage.create("LOGIN");
    initializingUI = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: ResponsiveHelper.wp,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ResponsiveHelper.borderRadiusLarge),
            topRight: Radius.circular(ResponsiveHelper.borderRadiusLarge),
          ),
        ),
        child: Form(
          key: _formKey,
          child: AppMargin(
            child: Column(
              children: [
                Text(
                  "VERIFY MOBILE NUMBER",
                  style: AppStyle.mediumStyle(
                    fontSize: ResponsiveHelper.fontLarge,
                  ),
                ),
                AppSpacer(hp: .03),

                AppSpacer(hp: .01),

                SizedBox(
                  width: ResponsiveHelper.wp * .85,
                  child: Pinput(
                    controller: _otpController,
                    length: 6,

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
                    errorPinTheme: AppTheme.pinTheme(color: AppColors.kRed),
                    followingPinTheme: AppTheme.pinTheme(),
                    disabledPinTheme: AppTheme.pinTheme(),
                    defaultPinTheme: AppTheme.pinTheme(),
                    focusedPinTheme: AppTheme.pinTheme(
                      color: AppColors.kPrimaryColor,
                    ),
                    submittedPinTheme: AppTheme.pinTheme(),
                  ),
                ),
                AppSpacer(hp: .01),
                BlocBuilder<AuthApiControllerBloc, AuthApiControllerState>(
                  builder: (context, state) {
                    if (state is AuthApiControllerErrorState) {
                      return AppResponseText(message: state.error);
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
                AppSpacer(hp: .01),

                BlocBuilder<AuthStateControllerCubit, AuthStateControllerState>(
                  builder: (context, state) {
                    return state.timer == null
                        ? TextButton(
                          onPressed: () {
                            final params =
                                context
                                        .read<AuthStateControllerCubit>()
                                        .state
                                        .params
                                    as Map<String, dynamic>?;
                            if (params != null) {
                              context.read<AuthApiControllerBloc>().add(
                                OnResendOTP(
                                  customerId: params['customerId'],
                                  context: context,
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Resend OTP",
                            style: AppStyle.normalStyle(
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        )
                        : Text(
                          "wait ${state.timer} seconds",
                          style: AppStyle.smallStyle(
                            color: AppColors.kPrimaryColor,
                          ),
                        );
                  },
                ),

                AppSpacer(hp: .01),
                BlocBuilder<AuthApiControllerBloc, AuthApiControllerState>(
                  builder: (context, state) {
                    return AppCustomButton(
                      isLoading: state is AuthApiControllerLoadingState,
                      title: "SUBMIT",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final params =
                              context
                                      .read<AuthStateControllerCubit>()
                                      .state
                                      .params
                                  as Map<String, dynamic>?;
                          if (params != null) {
                            context.read<AuthApiControllerBloc>().add(
                              OnVerifyOTP(
                                context: context,
                                customerId: params['customerId'],
                                otp: _otpController.text.trim(),
                              ),
                            );
                          }
                        }
                      },
                    );
                  },
                ),
                AppSpacer(hp: .02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Back to", style: AppStyle.normalStyle()),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthStateControllerCubit>()
                            .onChangeAuthTab(AuthTab.LOGIN);
                      },
                      child: Text(
                        "Login",
                        style: AppStyle.boldStyle(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
