import 'dart:developer';

import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/core/components/custom_network_img.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/settings/data/bloc/learn%20lang%20controller/learn_lang_selection_controller_cubit.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool initializingUI = true;
  late GetUiLanguage getUilang;

  Future<void> initUi() async {
    try {
      if (mounted) {
        await context
            .read<UiLanguageControllerCubit>()
            .getLanguagesForDropdown();
      }
      if (mounted) {
        await context.read<LearnLangControllerCubit>().onGetSettingsLanguages();
      }
      getUilang = await GetUiLanguage.create("SETTINGS");
      // await loadLanguages();
      initializingUI = false;
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        initUi();
      } catch (e) {
        initializingUI = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  // List<Map<String, dynamic>> newLanguages = [];
  // Future<void> loadLanguages() async {
  //   newLanguages = [];
  //   if (mounted) {
  //     final state = context.read<UiLanguageControllerCubit>().state;
  //     if (state is UiLanguageControllerSuccessState) {
  //       final languages = state.uiDropLanguages;
  //       for (var lang in languages) {
  //         final uiText = await context
  //             .read<UiLanguageControllerCubit>()
  //             .findText("LANGUAGE", lang.uiLanguageName);
  //         newLanguages.add({
  //           "title": uiText,
  //           "value": lang.uiLanguageId,
  //           "icon": lang.uiImageLight,
  //         });
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return initializingUI
        ? AppLoading()
        : BlocConsumer<UiLanguageControllerCubit, UiLanguageControllerState>(
          listener: (context, state) async {
            getUilang = await GetUiLanguage.create("SETTINGS");
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppMargin(
                    child: Column(
                      children: [
                        AppSpacer(hp: .01),
                        _buildChangeLangForAppViw(),
                        AppSpacer(hp: .02),
                        _buildLearnLangView(),
                        AppSpacer(hp: .01),
                      ],
                    ),
                  ),
                ),
                _buildButton(),

                // AppSpacer(hp: .04),
              ],
            );

            // Stack(
            //   children: [
            //     AppMargin(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           AppSpacer(hp: .01),
            //           _buildChangeLangForAppViw(),
            //           AppSpacer(hp: .02),
            //           _buildLearnLangView(),
            //           AppSpacer(hp: .01),
            //           _buildButton(),

            //           // AppSpacer(hp: .04),
            //         ],
            //       ),
            //     ),
            //     Positioned(
            //       bottom: 10,
            //       left: 15,
            //       right: 15,
            //       child: BlocBuilder<
            //         LearnLangControllerCubit,
            //         LearnLangControllerState
            //       >(
            //         builder: (context, learnLangbuttonState) {
            //           return BlocBuilder<
            //             UiLanguageControllerCubit,
            //             UiLanguageControllerState
            //           >(
            //             builder: (context, uiLangButtonState) {
            //               bool isButtonEnabled =
            //                   (learnLangbuttonState
            //                           is LearnLanguageSuccessState &&
            //                       learnLangbuttonState.enableUpdateButton) ||
            //                   (uiLangButtonState
            //                           is UiLanguageControllerSuccessState &&
            //                       uiLangButtonState.enableUpdateButton);

            //               bool isLoadingButton =
            //                   (learnLangbuttonState
            //                           is LearnLanguageSuccessState &&
            //                       learnLangbuttonState.isLoadingButton) ||
            //                   (uiLangButtonState
            //                           is UiLanguageControllerSuccessState &&
            //                       uiLangButtonState.isLoading);
            //               return AppCustomButton(
            //                 bgColor: isButtonEnabled ? null : AppColors.kGrey,
            //                 titleColor:
            //                     isButtonEnabled ? null : AppColors.kGreyLight,
            //                 isLoading: isLoadingButton,
            //                 title: getUilang.uiText(placeHolder: "SET005"),
            //                 width: ResponsiveHelper.wp,
            //                 onTap: () async {
            //                   bool canUpdateSettingsLangues =
            //                       learnLangbuttonState
            //                           is LearnLanguageSuccessState &&
            //                       learnLangbuttonState.enableUpdateButton;
            //                   bool canUpdateUILanguege =
            //                       uiLangButtonState
            //                           is UiLanguageControllerSuccessState &&
            //                       uiLangButtonState.enableUpdateButton;

            //                   if (canUpdateUILanguege) {
            //                     log("Updating UI lang");
            //                     await context
            //                         .read<UiLanguageControllerCubit>()
            //                         .onChangeEntireUiLanguage(
            //                           lang: uiLangButtonState.selectdLang!,
            //                         );

            //                     await context
            //                         .read<UiLanguageControllerCubit>()
            //                         .updateUiLanguageInServer();
            //                     await context
            //                         .read<NavControllerDartCubit>()
            //                         .initNav();

            //                     // await context
            //                     //     .read<LearnLangControllerCubit>()
            //                     //     .onGetSettingsLanguages();
            //                   }
            //                   if (canUpdateSettingsLangues) {
            //                     log("Updating Setting lang");
            //                     await context
            //                         .read<LearnLangControllerCubit>()
            //                         .onSetLearningLanguages(context);
            //                   }

            //                   if (canUpdateUILanguege ||
            //                       canUpdateSettingsLangues) {
            //                     context
            //                         .read<NavControllerDartCubit>()
            //                         .onChangeNavTab(0);
            //                   }
            //                 },
            //               );
            //             },
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // );
          },
        );
  }

  Widget _buildChangeLangForAppViw() {
    return BlocBuilder<UiLanguageControllerCubit, UiLanguageControllerState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getUilang.uiText(placeHolder: "SET002"),
              style: AppStyle.boldStyle(fontSize: ResponsiveHelper.fontMedium),
            ),
            AppSpacer(hp: .01),
            CustomDropDown(
              sufix:
                  state is UiLanguageControllerLoadingState
                      ? AppLoading()
                      : null,
              hintText: getUilang.uiText(placeHolder: "SET003"),
              selectedValue: state.selectdLang,
              width: ResponsiveHelper.wp,
              // selectedValue: state.language['title'],
              items: state.convertedLangsToDropDown.map((e) => e).toList(),
              onChanged: (value) async {
                context.read<UiLanguageControllerCubit>().onSelectLanguage(
                  lang: value,
                );
                // await context
                //     .read<UiLanguageControllerCubit>()
                //     .onChangeEntireUiLanguage(lang: value);

                // await context
                //     .read<UiLanguageControllerCubit>()
                //     .updateUiLanguageInServer();
                // context.read<NavControllerDartCubit>().initNav();

                // await context
                //     .read<LearnLangControllerCubit>()
                //     .onGetSettingsLanguages();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLearnLangView() {
    final controller = context.read<LearnLangControllerCubit>();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getUilang.uiText(placeHolder: "SET004"),
            style: AppStyle.boldStyle(fontSize: ResponsiveHelper.fontMedium),
          ),
          AppSpacer(hp: .01),
          Expanded(
            child: BlocBuilder<
              LearnLangControllerCubit,
              LearnLangControllerState
            >(
              builder: (context, state) {
                switch (state) {
                  case LearnLanguageSuccessState():
                    {
                      return GridView.builder(
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
                            onTap: () => controller.onAddToLanguage(lang),
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: ResponsiveHelper.wp,
      height: ResponsiveHelper.hp * .09,

      decoration: BoxDecoration(
        color: AppColors.kWhite,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, -5),
            spreadRadius: 2,
            blurRadius: 10,
            color: AppColors.kGrey.withAlpha(40),
          ),
          //  BoxShadow(
          //             offset: Offset(0, 0),
          //             blurRadius: 10,
          //             spreadRadius: -5,
          //             color: AppColors.kPrimaryLight.withAlpha(120),
          //           ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<LearnLangControllerCubit, LearnLangControllerState>(
            builder: (context, learnLangbuttonState) {
              return BlocBuilder<
                UiLanguageControllerCubit,
                UiLanguageControllerState
              >(
                builder: (context, uiLangButtonState) {
                  bool isButtonEnabled =
                      (learnLangbuttonState is LearnLanguageSuccessState &&
                          learnLangbuttonState.enableUpdateButton) ||
                      (uiLangButtonState is UiLanguageControllerSuccessState &&
                          uiLangButtonState.enableUpdateButton);

                  bool isLoadingButton =
                      (learnLangbuttonState is LearnLanguageSuccessState &&
                          learnLangbuttonState.isLoadingButton) ||
                      (uiLangButtonState is UiLanguageControllerSuccessState &&
                          uiLangButtonState.isLoading);
                  return AppCustomButton(
                    hideShadow: true,
                    bgColor: isButtonEnabled ? null : AppColors.kGrey,
                    titleColor: isButtonEnabled ? null : AppColors.kGreyLight,
                    isLoading: isLoadingButton,
                    title: getUilang.uiText(placeHolder: "SET005"),
                    width: ResponsiveHelper.wp,
                    onTap: () async {
                      bool canUpdateSettingsLangues =
                          learnLangbuttonState is LearnLanguageSuccessState &&
                          learnLangbuttonState.enableUpdateButton;
                      bool canUpdateUILanguege =
                          uiLangButtonState
                              is UiLanguageControllerSuccessState &&
                          uiLangButtonState.enableUpdateButton;

                      if (canUpdateUILanguege) {
                        log("Updating UI lang");
                        await context
                            .read<UiLanguageControllerCubit>()
                            .onChangeEntireUiLanguage(
                              lang: uiLangButtonState.selectdLang!,
                            );

                        await context
                            .read<UiLanguageControllerCubit>()
                            .updateUiLanguageInServer();
                        await context.read<NavControllerDartCubit>().initNav();

                        // await context
                        //     .read<LearnLangControllerCubit>()
                        //     .onGetSettingsLanguages();
                      }
                      if (canUpdateSettingsLangues) {
                        log("Updating Setting lang");
                        await context
                            .read<LearnLangControllerCubit>()
                            .onSetLearningLanguages(context);
                      }

                      if (canUpdateUILanguege || canUpdateSettingsLangues) {
                        if (learnLangbuttonState.selectedLanguages.isEmpty &&
                            canUpdateSettingsLangues) {
                          return;
                        }
                        context.read<NavControllerDartCubit>().onChangeNavTab(
                          0,
                        );
                      }
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
