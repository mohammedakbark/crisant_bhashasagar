import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${'welcome'.tr()}, Dr. Narayan",
                style: AppStyle.mediumStyle(
                  color: AppColors.kGrey,
                  fontSize: ResponsiveHelper.fontSmall,
                ),
              ),
              Text(
                "what_would_you_like_to_learn_today".tr(),
                style: AppStyle.boldStyle(
                  fontSize: ResponsiveHelper.fontMedium,
                ),
              ),
            ],
          ),
        ),
        AppSpacer(hp: .02),

        TextFormField(
          controller: _searchController,
          cursorColor: AppColors.kBlack,
          style: AppStyle.normalStyle(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.paddingSmall,
            ),
            prefixIcon: Icon(CupertinoIcons.search, color: AppColors.kGrey),
            hintText: 'search'.tr(),
            hintStyle: AppStyle.normalStyle(color: AppColors.kGrey),
            border: _searchBorder(),
            errorBorder: _searchBorder(),
            enabledBorder: _searchBorder(),
            focusedBorder: _searchBorder(),
            disabledBorder: _searchBorder(),
            focusedErrorBorder: _searchBorder(),
          ),
        ),

        AppSpacer(hp: .01),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => _buildItem(index),
            separatorBuilder: (context, index) => AppSpacer(hp: .01),
            itemCount: 5,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _searchBorder() => OutlineInputBorder(
    borderSide: BorderSide(width: .2),
    borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall),
  );

  Widget _buildItem(int index) {
    final bgColor =
        index.isEven ? AppColors.kSecondary : AppColors.kPrimaryLight;
    return GestureDetector(
      onTap: () {
        context.push(learningPathScreen, extra: {"language": "English"});
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveHelper.paddingLarge,
          horizontal: ResponsiveHelper.paddingXLarge,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: bgColor),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              color: bgColor.withAlpha(120),
            ),
          ],
          color: bgColor.withAlpha(50),
          borderRadius: BorderRadius.circular(
            ResponsiveHelper.borderRadiusXLarge,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "English",
                      style: AppStyle.boldStyle(
                        fontSize: ResponsiveHelper.fontRegular,
                      ),
                    ),
                    Text(
                      "7 ${'lessons'.tr()}",
                      style: AppStyle.smallStyle(
                        // fontSize: ResponsiveHelper.fontRegular,
                      ),
                    ),
                  ],
                ),
                Text(
                  "E",
                  style: AppStyle.mediumStyle(
                    fontSize: ResponsiveHelper.wp * .2,
                  ),
                ),
              ],
            ),

            LinearProgressIndicator(
              value: .9,
              borderRadius: BorderRadius.circular(50),
              color: AppColors.kPrimaryDark,
              backgroundColor: AppColors.kPrimaryDark.withAlpha(120),
            ),
          ],
        ),
      ),
    );
  }
}
