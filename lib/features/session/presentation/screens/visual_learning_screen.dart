import 'package:bashasagar/core/components/app_back_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';

class VisualLearningScreen extends StatelessWidget {
  final String language;
  VisualLearningScreen({super.key, required this.language});
  final languages = [
    {"title": "English", "value": "English"},
    {"title": "Kannada", "value": "Kannada"},
    {"title": "Hindi", "value": "Hindi"},
  ];
  Map<String, dynamic>? selctedLang;
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
      body: AppMargin(
        child: Column(
          children: [
            AppSpacer(hp: .02),
            Text(
              textAlign: TextAlign.center,
              "Shall we go to the Department store today ?",
              style: AppStyle.boldStyle(fontSize: ResponsiveHelper.fontMedium),
            ),
            AppSpacer(hp: .02),
            Container(
              width: ResponsiveHelper.wp,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.borderRadiusMedium,
                ),
                color: AppColors.kPrimaryColor,
              ),
            ),

            AppSpacer(hp: .02),
            CustomDropDown(
              selectedValue: languages.first,
              prefix: Icon(CupertinoIcons.globe, color: AppColors.kGrey),
              labelText: "Choose Script",
              width: ResponsiveHelper.wp,
              items: languages,
              onChanged: (value) {},
            ),
            AppSpacer(hp: .02),
            Text(
              textAlign: TextAlign.center,
              "Shall we go to the Department store today ?",
              style: AppStyle.boldStyle(fontSize: ResponsiveHelper.fontMedium),
            ),
            AppSpacer(hp: .04
            
            
            ),

            IconButton.filled(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.kOrange),
              ),
              color: AppColors.kWhite,
              onPressed: () {},
              icon: Padding(
                padding: EdgeInsets.all(20),
                child: Icon(CupertinoIcons.speaker_3),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(onPressed: () {}, title: 'Previous'),
                _buildButton(onPressed: () {}, title: "Next"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({void Function()? onPressed, required String title}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.kPrimaryColor),
      onPressed: onPressed,
      child: Text(title, style: AppStyle.mediumStyle(color: AppColors.kWhite)),
    );
  }
}
