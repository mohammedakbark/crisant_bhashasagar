import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LearningPathScreen extends StatelessWidget {
  final String language;
  const LearningPathScreen({super.key, required this.language});

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
      body: GridView.builder(
        padding: EdgeInsets.all(ResponsiveHelper.paddingSmall),
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ResponsiveHelper.paddingSmall,
          mainAxisSpacing: ResponsiveHelper.paddingSmall,
        ),
        itemBuilder:
            (context, index) => GestureDetector(
              onTap:
                  () => context.push(
                    topicListScreen,
                    extra: {"language": language},
                  ),

              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGrey, width: 2),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.borderRadiusLarge,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
