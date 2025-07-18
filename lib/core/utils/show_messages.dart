import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

void showToast(String message, {bool isError = false}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,

    backgroundColor: isError ? AppColors.kRed : AppColors.kBlack,
    textColor: AppColors.kWhite,
    fontSize: 12.0,
  );
}

void showSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.all(5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? AppColors.kRed : AppColors.kGrey,
      content: Text(message,style: AppStyle.normalStyle(color: AppColors.kWhite,fontSize: 14),),
    ),
  );
}
