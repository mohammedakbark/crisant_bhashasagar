import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class AppTheme {
  static ThemeData themeData() => ThemeData(
        textTheme: AppTheme.buildTextTheme(
          AppStyle.smallStyle(),
          AppStyle.mediumStyle(),
          AppStyle.largeStyle(),
        ),
        scaffoldBackgroundColor: AppColors.kBgColor,
        iconTheme: IconThemeData(color: AppColors.kGrey),
        appBarTheme: AppBarTheme(
            centerTitle: false,
         
            backgroundColor: AppColors.kBgColor),
        colorScheme: ColorScheme.dark(primary: AppColors.kPrimaryColor),
      );

  static TextTheme buildTextTheme(
    TextStyle small,
    TextStyle medium,
    TextStyle large,
  ) {
    return TextTheme(
      titleSmall: small,
      titleMedium: medium,
      titleLarge: large,
      bodySmall: small,
      bodyMedium: medium,
      bodyLarge: large,
      displaySmall: small,
      displayMedium: medium,
      displayLarge: large,
      headlineSmall: small,
      headlineMedium: medium,
      headlineLarge: large,
      labelSmall: small,
      labelMedium: medium,
      labelLarge: large,
    );
  }

 static PinTheme pinTheme({Color? color}) => PinTheme(
    width: ResponsiveHelper.wp / 6,
    height: ResponsiveHelper.hp * .065,
    textStyle: AppStyle.largeStyle(fontSize: ResponsiveHelper.fontLarge),

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusMedium),
      color: AppColors.kWhite,
      border: Border.all(color: color ?? AppColors.kGrey, width: .5),
    ),
  );
}
