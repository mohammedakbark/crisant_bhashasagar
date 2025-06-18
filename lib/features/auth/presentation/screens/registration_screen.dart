import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthSuccessScreen extends StatelessWidget {
  final String successTitle;
  final String successMessage;
  final String buttonTitle;
  final String nextScreen;
  const AuthSuccessScreen({
    super.key,
    required this.successTitle,
    required this.successMessage,
    required this.buttonTitle,
    required this.nextScreen,
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
                  color: AppColors.kPrimaryLight,
                ),
              ),
              SlideInUp(
                child: Container(
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
                          FluentIcons.checkmark_underline_circle_16_regular,
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
                            context.go(nextScreen);
                          },
                        ),

                        AppSpacer(hp: .04),
                      ],
                    ),
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
