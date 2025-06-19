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

class Register extends StatelessWidget {
  Register({super.key});
  final _regNameController = TextEditingController();
  final _regMobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
                "NEW USER",
                style: AppStyle.mediumStyle(fontSize: ResponsiveHelper.fontLarge),
              ),
              AppSpacer(hp: .03),
              CustomeTextField(
                prefix: Icon(SolarIconsOutline.user),
                lebelText: "Full name",
                controller: _regNameController,
                validator: AppValidator.mobileNumberValidator,
              ),
              AppSpacer(hp: .02),
              CustomeTextField(
                prefix: Icon(SolarIconsOutline.phone),
                  keyboardType: TextInputType.number,
                lebelText: "Mobile number",
                controller: _regMobileController,
                validator: AppValidator.mobileNumberValidator,
              ),
              AppSpacer(hp: .02),
              CustomeTextField(
                isObsecure: true,
                prefix: Icon(SolarIconsOutline.lock),
                lebelText: 'Password',
                controller: _passwordController,
                validator: AppValidator.requiredValidator,
              ),
              AppSpacer(hp: .02),
              CustomeTextField(
                isObsecure: true,
                prefix: Icon(SolarIconsOutline.lock),
                lebelText: 'Repeat Password',
                controller: _confirmPasswordController,
                validator: AppValidator.requiredValidator,
              ),
              AppSpacer(hp: .05),
      
              AppCustomButton(title: "REGISTER",onTap: () {
                 context.read<AuthStateControllerCubit>().onChangeAuthTab(
                        AuthTab.VERIFYOTP,
                      );
              },),
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
