import 'dart:developer';

import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/localization/localization_controller_cubit.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/settings/data/bloc/language%20selection%20controller/language_selection_controller_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LocalizationControllerCubit>().initCurrentLan(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
          BlocBuilder<LocalizationControllerCubit, LocalizationControllerState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChangeLangForAppViw(state),
                  AppSpacer(hp: .04),
                  _buildLearnLangView(),
                ],
              );
            },
          ),
    );
  }

  Widget _buildChangeLangForAppViw(LocalizationControllerState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "change_lan_for_app".tr(),
          style: AppStyle.boldStyle(fontSize: ResponsiveHelper.fontMedium),
        ),
        AppSpacer(hp: .02),
        CustomDropDown(
          width: ResponsiveHelper.wp,
          selectedValue: state.language['title'],
          items: context.read<LocalizationControllerCubit>().languages,
          onChanged: (map) {
            context.read<LocalizationControllerCubit>().onchangeLangauge(
              context,
              map,
            );
          },
          enableTextLetter: true,
        ),
      ],
    );
  }

  Widget _buildLearnLangView() {
    final controller = context.read<LanguageSelectionControllerCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "choose_lang_to_learn".tr(),
          style: AppStyle.boldStyle(fontSize: ResponsiveHelper.fontMedium),
        ),
        AppSpacer(hp: .02),
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
                    padding: EdgeInsets.all(ResponsiveHelper.paddingMedium),
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

        AppSpacer(hp: .03),
        AppCustomButton(
          title: "UPDATE",
          width: ResponsiveHelper.wp,
          onTap: () {},
        ),
      ],
    );
  }
}
