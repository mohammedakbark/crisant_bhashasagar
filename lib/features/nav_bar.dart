import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  bool initializingUI = true;
  late GetUiLanguage getUilang;
  late String homeText;
  late String profileText;
  late String settingsText;
  late String searchText;

  void initUi() async {
    getUilang = await GetUiLanguage.create("NAV");
    homeText = getUilang.uiText(placeHolder: "NAV001");
    profileText = getUilang.uiText(placeHolder: "NAV004");
    settingsText = getUilang.uiText(placeHolder: "NAV003");
    searchText = getUilang.uiText(placeHolder: "NAV002");
    initializingUI = false;
    setState(() {});
  }

  @override
  void initState() {
    initUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initializingUI
        ? SizedBox.shrink()
        : SlideInUp(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                // BoxShadow(
                //   blurRadius: 10,
                //   color: AppColors.kPrimaryLight.withAlpha(120),
                // ),
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: -5,
                  color: AppColors.kPrimaryLight.withAlpha(120),
                ),
              ],
            ),
            child: BlocBuilder<NavControllerDartCubit, NavControllerDartState>(
              builder: (context, navState) {
                return BlocConsumer<
                  UiLanguageControllerCubit,
                  UiLanguageControllerState
                >(
                  listener: (context, state) async {
                    // if (navState.currentIndex == 2) {
                    //   initializingUI = true;
                    //   setState(() {});
                    //   getUilang = await GetUiLanguage.create("NAV");
                    //   homeText = getUilang.uiText(placeHolder: "NAV001");
                    //   profileText = getUilang.uiText(placeHolder: "NAV004");
                    //   settingsText = getUilang.uiText(placeHolder: "NAV003");
                    //   searchText = getUilang.uiText(placeHolder: "NAV002");
                    //   initializingUI = false;
                    //   setState(() {});
                    // }
                  },
                  builder: (context, state) {
                    return BottomNavigationBar(
                      currentIndex: navState.currentIndex,
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      selectedIconTheme: IconThemeData(
                        fill: .5,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 1),
                            blurRadius: 1,
                            color: AppColors.kPrimaryColor.withAlpha(120),
                          ),
                        ],
                      ),
                      selectedItemColor: AppColors.kPrimaryColor,
                      unselectedItemColor: AppColors.kGrey,
                      onTap:
                          context.read<NavControllerDartCubit>().onChangeNavTab,
                      items: [
                        BottomNavigationBarItem(
                          backgroundColor: AppColors.kWhite,
                          label: homeText,
                          activeIcon: _buildActiveIcon(
                            SolarIconsBold.homeAngle_2,
                          ),
                          icon: Icon(SolarIconsOutline.homeAngle_2),
                        ),
                        BottomNavigationBarItem(
                          label: searchText,
                          activeIcon: _buildActiveIcon(
                            SolarIconsBold.lightbulbBold,
                          ),
                          icon: Icon(SolarIconsOutline.lightbulbBold),
                        ),
                        BottomNavigationBarItem(
                          label: settingsText,
                          activeIcon: _buildActiveIcon(SolarIconsBold.tuning_4),
                          icon: Icon(SolarIconsOutline.tuning_4),
                        ),
                        BottomNavigationBarItem(
                          label: profileText,
                          activeIcon: _buildActiveIcon(SolarIconsBold.user),
                          icon: Icon(SolarIconsOutline.user),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
  }

  Widget _buildActiveIcon(IconData icon) {
    return Container(
      // padding: EdgeInsets.all(ResponsiveHelper.paddingSmall),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall),
      //   color: AppColors.kPrimaryLight.withAlpha(120),
      // ),
      child: Icon(icon),
    );
  }
}
