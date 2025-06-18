import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/theme/app_theme.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/core/utils/validators.dart';
import 'package:bashasagar/features/auth/data/bloc/cubit/auth_state_controller_cubit.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final _mobileNumberController = TextEditingController();
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
                "FORGOT PASSWORD",
                style: AppStyle.mediumStyle(
                  fontSize: ResponsiveHelper.fontLarge,
                ),
              ),
              AppSpacer(hp: .03),

              CustomeTextField(
                keyboardType: TextInputType.number,
                prefix: Icon(FluentIcons.phone_32_regular),
                lebelText: 'Mobile number',
                controller: _mobileNumberController,
                validator: AppValidator.mobileNumberValidator,
              ),
              AppSpacer(hp: .01),

              TextButton(
                onPressed: () {},
                child: Text("Send OTP", style: AppStyle.boldStyle()),
              ),

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
              TextButton(
                onPressed: () {},
                child: Text(
                  "Resend OTP",
                  style: AppStyle.normalStyle(color: AppColors.kPrimaryColor),
                ),
              ),

              AppSpacer(hp: .01),

              AppCustomButton(
                title: "RESET",
                onTap: () {
                  context.read<AuthStateControllerCubit>().onChangeAuthTab(
                    AuthTab.RESETPASSWORD,
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
