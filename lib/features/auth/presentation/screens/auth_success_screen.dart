import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/const/img_const.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';

class AuthSuccessScreen extends StatelessWidget {
  final String successTitle;
  final String successMessage;
  final String buttonTitle;
  final AuthTab nextAuthTab;
  const AuthSuccessScreen({
    super.key,
    required this.successTitle,
    required this.successMessage,
    required this.buttonTitle,
    required this.nextAuthTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.kPrimaryColor,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 39, vertical: 30),
                  // color: AppColors.kPrimaryLight,
                  child: Image.asset(ImgConst.success),
                ),
              ),
              Container(
                width: ResponsiveHelper.wp,
                padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(ResponsiveHelper.borderRadiusLarge),
                    right: Radius.circular(
                      ResponsiveHelper.borderRadiusLarge,
                    ),
                  ),
                ),
                child: AppMargin(
                  child: Column(
                    children: [
                      Text(
                        successTitle,
                        style: AppStyle.mediumStyle(
                          fontSize: ResponsiveHelper.fontLarge,
                        ),
                      ),
                      AppSpacer(hp: .03),
                      Icon(
                        SolarIconsOutline.checkCircle,
                        size: 200,
                        color: AppColors.kPrimaryColor,
                      ),
                      AppSpacer(hp: .03),
                      Text(
                        successMessage,
                        style: AppStyle.smallStyle(
                          // fontSize: ResponsiveHelper.fontLarge,
                        ),
                      ),
                      AppSpacer(hp: .04),
              
                      AppCustomButton(
                        title: buttonTitle,
                        onTap: (){
                          context.read<AuthStateControllerCubit>().onChangeAuthTab(nextAuthTab);
                          context.go(authScreen);
                        },
                      ),
              
                      AppSpacer(hp: .04),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
