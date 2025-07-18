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
  final void Function(int)? onTap;

  const AppNavBar({super.key, this.onTap});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  // bool initializingUI = true;
  // late GetUiLanguage getUilang;
  // late String homeText;
  // late String profileText;
  // late String settingsText;
  // late String searchText;

  // void initUi() async {
  //   getUilang = await GetUiLanguage.create("NAV");
  //   homeText = getUilang.uiText(placeHolder: "NAV001");
  //   profileText = getUilang.uiText(placeHolder: "NAV004");
  //   settingsText = getUilang.uiText(placeHolder: "NAV003");
  //   searchText = getUilang.uiText(placeHolder: "NAV002");
  //   initializingUI = false;
  //   setState(() {});
  // }

  @override
  void initState() {
    // initUi();
    context.read<NavControllerDartCubit>().initNav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: BlocBuilder<NavControllerDartCubit, NavControllerDartState>(
        builder: (context, navState) {
          return BlocBuilder<
            UiLanguageControllerCubit,
            UiLanguageControllerState
          >(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow:navState.currentIndex==2?null: [
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
                child: BottomNavigationBar(
                  backgroundColor:
                      AppColors.kWhite, // fixedColor: AppColors.kWhite,
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
                      widget.onTap == null
                          ? context
                              .read<NavControllerDartCubit>()
                              .onChangeNavTab
                          : (index) {
                            widget.onTap!(index);
                            context
                                .read<NavControllerDartCubit>()
                                .onChangeNavTab(index);
                          },
                  items: [
                    BottomNavigationBarItem(
                      backgroundColor: AppColors.kWhite,

                      label: navState.homeText,
                      activeIcon: _buildActiveIcon(SolarIconsBold.homeAngle_2),
                      icon: Icon(SolarIconsOutline.homeAngle_2),
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: AppColors.kWhite,

                      label: navState.searchText,
                      activeIcon: _buildActiveIcon(
                        SolarIconsBold.lightbulbBold,
                      ),
                      icon: Icon(SolarIconsOutline.lightbulbBold),
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: AppColors.kWhite,
                      label: navState.settingsText,
                      activeIcon: _buildActiveIcon(SolarIconsBold.tuning_4),
                      icon: Icon(SolarIconsOutline.tuning_4),
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: AppColors.kWhite,
                      label: navState.profileText,
                      activeIcon: _buildActiveIcon(SolarIconsBold.user),
                      icon: Icon(SolarIconsOutline.user),
                    ),
                  ],
                ),
              );
            },
          );
        },
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
