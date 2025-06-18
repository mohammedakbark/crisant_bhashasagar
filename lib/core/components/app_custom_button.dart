import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class AppCustomButton extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Color? bgColor;
  final Color? titleColor;
  final TextStyle? titleStyle;
  final double? radius;
  final void Function()? onTap;
  final bool isLoading;

  const AppCustomButton({
    super.key,
    this.title,
    this.child,
    this.bgColor,
    this.titleStyle,
    this.radius,
    this.titleColor,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isButtonDisabled = onTap == null;
    return isLoading
        ? AppLoading()
        : GestureDetector(
          behavior: HitTestBehavior.translucent,

          onTap: onTap,
          child: Container(
            alignment: Alignment.center,

            width: ResponsiveHelper.wp * .85,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  // spreadRadius: 1,
                  blurRadius: 15,
                  offset: Offset(0, 4),
                  color:
                      isButtonDisabled
                          ? AppColors.kPrimaryLight.withAlpha(120)
                          : bgColor != null
                          ? bgColor!.withAlpha(120)
                          : AppColors.kPrimaryColor.withAlpha(120),
                ),
              ],
              color:
                  isButtonDisabled
                      ? AppColors.kPrimaryLight.withAlpha(150)
                      : bgColor ?? AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(
                radius ?? ResponsiveHelper.borderRadiusSmall,
              ),
            ),
            child:
                child ??
                (title != null
                    ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 16,
                      ),
                      child: Text(
                        title!,
                        style:
                            titleStyle ??
                            AppStyle.mediumStyle(
                              color: titleColor ?? AppColors.kWhite,
                            ),
                      ),
                    )
                    : SizedBox()),
          ),
        );
  }
}
