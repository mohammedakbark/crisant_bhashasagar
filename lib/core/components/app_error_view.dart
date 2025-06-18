
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class AppErrorView extends StatelessWidget {
  final String error;
  final String? errorExp;
  final Widget? icon;
  final void Function()? onRetry;

  const AppErrorView({
    super.key,
    this.icon,
    required this.error,
    this.errorExp,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    bool isTokenExpire = error == "jwt expired" ? true : false;
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              icon ??
                  Icon(
                    Icons.smart_toy_outlined,
                    color: AppColors.kBlack,
                    size: 70,
                  ),
              AppSpacer(hp: .01),
            ],
          ),

          Text(
            textAlign: TextAlign.center,
            isTokenExpire ? "Session is expired." : error,
            style: AppStyle.largeStyle(
              
                color: AppColors.kBlack),
          ),

          // Subtite
          isTokenExpire
              ? Column(
                  children: [
                    AppSpacer(hp: .005),
                    Text(
                      textAlign: TextAlign.center,
                      "Please login again..",
                      style: AppStyle.smallStyle(
                       
                        color: AppColors.kBlack,
                      ),
                    ),
                  ],
                )
              : SizedBox(),

          // Token - Expired

          errorExp != null
              ? Column(
                  children: [
                    AppSpacer(hp: .01),
                    Text(
                      textAlign: TextAlign.center,
                      errorExp!,
                      style: AppStyle.smallStyle(
                     
                        color: AppColors.kBlack,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          // Refresh
          onRetry != null
              ? Column(
                  children: [
                    AppSpacer(hp: .01),
                    ElevatedButton(
                      onPressed: isTokenExpire
                          ? () {}
                          : onRetry,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        textDirection:
                            isTokenExpire ? TextDirection.rtl : null,
                        children: [
                          Text(
                            isTokenExpire ? "Logout" : "Try again",
                            style: AppStyle.boldStyle(
                              color: AppColors.kPrimaryColor,
                             
                            ),
                          ),
                          AppSpacer(wp: .01),
                          Icon(
                           
                              isTokenExpire
                                  ? Icons.logout
                                  : Icons.refresh),
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
