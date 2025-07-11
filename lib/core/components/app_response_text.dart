import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppResponseText extends StatelessWidget {
  final String message;
  const AppResponseText({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: AppMargin(
        child: Row(
          children: [
            Flexible(
              child: Text(
                message,
                style: AppStyle.mediumStyle(color: AppColors.kRed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
