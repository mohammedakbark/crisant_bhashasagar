import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final String? buttonTitle;
  final bool? hideShadow;

  final void Function()? onTap;
  final void Function()? goBack;

  const AppBackButton({
    super.key,
    this.buttonTitle,
    this.onTap,
    this.goBack,
    this.hideShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goBack ?? () => Navigator.pop(context),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.paddingSmall),
        child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.kWhite),
      ),
    );
  }
}
