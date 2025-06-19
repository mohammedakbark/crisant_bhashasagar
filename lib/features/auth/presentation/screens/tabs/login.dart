import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/core/utils/validators.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final _loginMobileController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: Container(
        width: ResponsiveHelper.wp,
        padding: EdgeInsets.symmetric(vertical: 30),
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
                "LOGIN",
                style: AppStyle.mediumStyle(fontSize: ResponsiveHelper.fontLarge),
              ),
              AppSpacer(hp: .03),
              CustomeTextField(
                keyboardType: TextInputType.number,
                prefix: Icon(SolarIconsOutline.phone),
                lebelText: "Mobile number",
                controller: _loginMobileController,
                validator: AppValidator.mobileNumberValidator,
              ),
              AppSpacer(hp: .03),
              CustomeTextField(
                isObsecure: true ,
                prefix: Icon(SolarIconsOutline.lock),
                lebelText: 'Password',
                controller: _loginPasswordController,
                validator: AppValidator.requiredValidator,
              ),
              AppSpacer(hp: .01),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<AuthStateControllerCubit>().onChangeAuthTab(
                        AuthTab.FORGETPASSWORD,
                      );
                    },
                    child: Text(
                      "Forget Password ?",
                      style: AppStyle.normalStyle(),
                    ),
                  ),
                ],
              ),
              AppSpacer(hp: .01),
              AppCustomButton(title: "LOGIN"),
              AppSpacer(hp: .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New user ?", style: AppStyle.normalStyle()),
                  TextButton(
                    onPressed: () {
                      context.read<AuthStateControllerCubit>().onChangeAuthTab(
                        AuthTab.REGISTER,
                      );
                    },
                    child: Text(
                      "Register here",
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
