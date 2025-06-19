import 'package:bashasagar/core/components/app_back_button.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class VisualLearningScreen extends StatelessWidget {
  final String language;
  const VisualLearningScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: SizedBox.shrink(),
        ),
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: AppColors.kPrimaryColor,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        actions: [Text("5/30", style: AppStyle.boldStyle())],

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // AppBackButton(),
                Text(
                  language,
                  style: AppStyle.boldStyle(color: AppColors.kWhite),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveHelper.paddingSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: ResponsiveHelper.wp / 2,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(100),
                      value: .6,
                      color: Colors.amber,
                      backgroundColor: AppColors.kWhite,
                    ),
                  ),
                  AppSpacer(hp: .005),

                  Text(
                    "60%",
                    style: AppStyle.boldStyle(
                      color: AppColors.kWhite,
                      fontSize: ResponsiveHelper.fontExtraSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(children: []),
    );
  }
}
