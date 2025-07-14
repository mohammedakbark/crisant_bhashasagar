import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_network_img.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/settings/data/bloc/learn%20lang%20controller/learn_lang_selection_controller_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    initUi();
    super.initState();
  }

  bool initializingUI = true;
  late GetUiLanguage getUilang;

  void initUi() async {
    getUilang = await GetUiLanguage.create("SETTINGSINIT");
    initializingUI = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LearnLangControllerCubit>();
    return Scaffold(
      body:
          initializingUI
              ? AppLoading()
              : SingleChildScrollView(
                child: SafeArea(
                  child: AppMargin(
                    child: Column(
                      children: [
                        Text(
                          getUilang.uiText(placeHolder: "SET001"),
                          style: AppStyle.boldStyle(),
                        ),
                        AppSpacer(hp: .04),
                        Text(
                          getUilang.uiText(placeHolder: "SET002"),
                          style: AppStyle.boldStyle(),
                        ),
                        AppSpacer(hp: .01),
                        Text(
                          getUilang.uiText(placeHolder: "SET003"),
                          textAlign: TextAlign.center,
                          style: AppStyle.normalStyle(),
                        ),
                        AppSpacer(hp: .04),
                        BlocBuilder<
                          LearnLangControllerCubit,
                          LearnLangControllerState
                        >(
                          builder: (context, state) {
                            switch (state) {
                              case LearnLanguageSuccessState():
                                {
                                  return GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.languages.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                        ),
                                    itemBuilder: (context, index) {
                                      final lang = state.languages[index];
                                      bool isSelected = controller
                                          .isLanguageSelected(lang);
                                      return InkWell(
                                        // onTap: () => controller.onAddToLangauge(lang),
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(
                                            ResponsiveHelper.paddingMedium,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              ResponsiveHelper
                                                  .borderRadiusMedium,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width:
                                                    ResponsiveHelper.wp * .13,
                                                height:
                                                    ResponsiveHelper.wp * .12,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        ResponsiveHelper
                                                            .borderRadiusMedium,
                                                      ),
                                                  color:
                                                      isSelected
                                                          ? AppColors.kWhite
                                                          : AppColors
                                                              .kGreyLight,
                                                ),
                                                // child: Text(
                                                //   lang.languageName,
                                                //   style: AppStyle.mediumStyle(
                                                //     fontSize: ResponsiveHelper.fontLarge,
                                                //     color:
                                                //         isSelected
                                                //             ? AppColors.kPrimaryColor
                                                //             : AppColors.kBlack,
                                                //   ),
                                                // ),
                                                child: CustomNetworkImg(
                                                  path: lang.lanuageImageDark,
                                                ),
                                              ),
                                              AppSpacer(hp: .01),
                                              Flexible(
                                                child: Text(
                                                  maxLines: 1,
                                                  lang.languageName,
                                                  style: AppStyle.mediumStyle(
                                                    color:
                                                        isSelected
                                                            ? AppColors.kWhite
                                                            : AppColors.kBlack,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              case LearnLanguageErrorState():
                                {
                                  return AppErrorView(error: state.error);
                                }
                              default:
                                {
                                  return AppLoading();
                                }
                            }
                          },
                        ),
                        AppSpacer(hp: .02),
                        BlocBuilder<
                          LearnLangControllerCubit,
                          LearnLangControllerState
                        >(
                          builder: (context, state) {
                            return AppCustomButton(
                              onTap:
                                  controller.state.selectedLanguages.isEmpty
                                      ? null
                                      : () {
                                        context.go(routeScreen);
                                      },
                              title: getUilang.uiText(placeHolder: "SET004"),
                            );
                          },
                        ),
                        AppSpacer(hp: .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.info_circle, size: 15),
                            AppSpacer(wp: .01),
                            Text(
                              getUilang.uiText(placeHolder: "SET005"),
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
