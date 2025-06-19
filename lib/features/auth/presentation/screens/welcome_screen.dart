import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/settings/data/bloc/language%20selection%20controller/language_selection_controller_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LanguageSelectionControllerCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: AppMargin(
            child: Column(
              children: [
                Text("Welcome", style: AppStyle.boldStyle()),
                AppSpacer(hp: .04),
                Text(
                  "Choose the language you would like to learn",
                  style: AppStyle.boldStyle(),
                ),
                AppSpacer(hp: .01),
                Text(
                  """Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam exerci tation ullamcorper""",
                  textAlign: TextAlign.center,
                  style: AppStyle.normalStyle(),
                ),
                AppSpacer(hp: .04),
                BlocBuilder<
                  LanguageSelectionControllerCubit,
                  LanguageSelectionControllerState
                >(
                  builder: (context, state) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.languages.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final lang = state.languages[index];
                        bool isSelected = controller.isLanguageSelected(lang);
                        return InkWell(
                          onTap: () => controller.onAddToLangauge(lang),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(
                              ResponsiveHelper.paddingMedium,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.borderRadiusMedium,
                              ),
                              border: Border.all(
                                width: .5,
                                color: AppColors.kPrimaryColor,
                              ),
                              color:
                                  isSelected
                                      ? AppColors.kPrimaryColor
                                      : AppColors.kWhite,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: ResponsiveHelper.wp * .13,
                                  height: ResponsiveHelper.wp * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      ResponsiveHelper.borderRadiusMedium,
                                    ),
                                    color:
                                        isSelected
                                            ? AppColors.kWhite
                                            : AppColors.kGreyLight,
                                  ),
                                  child: Text(
                                    lang[0].toUpperCase(),
                                    style: AppStyle.mediumStyle(
                                      fontSize: ResponsiveHelper.fontLarge,
                                      color:
                                          isSelected
                                              ? AppColors.kPrimaryColor
                                              : AppColors.kBlack,
                                    ),
                                  ),
                                ),
                                AppSpacer(hp: .01),
                                Text(
                                  lang,
                                  style: AppStyle.mediumStyle(
                                    color:
                                        isSelected
                                            ? AppColors.kWhite
                                            : AppColors.kBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                AppSpacer(hp: .02),
                BlocBuilder<
                  LanguageSelectionControllerCubit,
                  LanguageSelectionControllerState
                >(
                  builder: (context, state) {
                    return AppCustomButton(
                      onTap: controller.state.selectedLanguages.isEmpty?null:(){
                        context.go(routeScreen);
                      },
                      title: "START YOUR JOURNEY");
                  }
                ),
                AppSpacer(hp: .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.info_circle, size: 15),
                    AppSpacer(wp: .01),
                    Text(
                      "You can still change your language later.",
                      style: AppStyle.smallStyle(
                        fontSize: ResponsiveHelper.fontSmall,
                      ),
                    ),
                  ],
                ),
                AppSpacer(hp: .02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
