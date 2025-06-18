import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/theme/app_theme.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/auth/data/bloc/cubit/auth_state_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends StatelessWidget {
  VerifyOtp({super.key});
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: ResponsiveHelper.wp,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(ResponsiveHelper.borderRadiusLarge),
            right: Radius.circular(ResponsiveHelper.borderRadiusLarge),
          ),
        ),
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
              AppSpacer(hp: .02),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Resend OTP",
                  style: AppStyle.normalStyle(color: AppColors.kPrimaryColor),
                ),
              ),

              AppSpacer(hp: .01),
              AppCustomButton(
                title: "SUBMIT",
                onTap: () {
                  context.go(
                    authSuccessScreen,
                    extra: {
                      "successTitle": "SIGN UP SUCCESSFULLY",
                      "successMessage":
                          "Your account has been created successfully.",
                      "buttonTitle": "LOGIN",
                      "nextScreen":routeScreen
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
                      context.read<AuthStateControllerCubit>().onChangeAuthTab(
                        AuthTab.LOGIN,
                      );
                    },
                    child: Text(
                      "Login",
                      style: AppStyle.boldStyle(color: AppColors.kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
