import 'package:bashasagar/core/const/appcolors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static final _defaultStyle = GoogleFonts.inter;

  static TextStyle normalStyle({
    double? fontSize,
    Color? color,
    double? spacing,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    List<Shadow>? shadows,
  }) => _defaultStyle(
    shadows: shadows,
    fontWeight: fontWeight ?? FontWeight.normal,
    fontSize: fontSize,
    decorationColor: color ?? AppColors.kBlack,

    color: color ?? AppColors.kBlack,
    letterSpacing: spacing,
    decoration: decoration,
  );

  static TextStyle boldStyle({
    double? fontSize,
    Color? color,
    double? spacing,
    TextDecoration? decoration,
    FontWeight? fontWeight,

    List<Shadow>? shadows,
  }) => _defaultStyle(
    shadows: shadows,

    fontWeight: fontWeight ?? FontWeight.bold,
    fontSize: fontSize,
    decorationColor: color ?? AppColors.kBlack,

    color: color ?? AppColors.kBlack,
    letterSpacing: spacing,
    decoration: decoration,
  );

  static TextStyle smallStyle({
    double? fontSize,
    Color? color,
    double? spacing,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    List<Shadow>? shadows,
  }) => _defaultStyle(
    shadows: shadows,
    fontWeight: fontWeight ?? FontWeight.w300,
    decorationColor: color ?? AppColors.kBlack,

    fontSize: fontSize,
    color: color ?? AppColors.kBlack,
    letterSpacing: spacing,
    decoration: decoration,
  );

  static TextStyle mediumStyle({
    double? fontSize,
    Color? color,
    double? spacing,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    List<Shadow>? shadows,
  }) => _defaultStyle(
    shadows: shadows,
    fontWeight: fontWeight ?? FontWeight.w500,
    decorationColor: color ?? AppColors.kBlack,
    fontSize: fontSize,
    color: color ?? AppColors.kBlack,
    letterSpacing: spacing,
    decoration: decoration,
  );

  static TextStyle largeStyle({
    double? fontSize,
    Color? color,
    double? spacing,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    List<Shadow>? shadows,
  }) => _defaultStyle(
    shadows: shadows,
    decorationColor: color ?? AppColors.kBlack,

    fontWeight: fontWeight ?? FontWeight.w800,
    fontSize: fontSize,
    color: color ?? AppColors.kBlack,
    letterSpacing: spacing,
    decoration: decoration,
  );
}
