import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
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
          builder: (context, state) {
            return BottomNavigationBar(
              
              currentIndex: state.currentIndex,
              showSelectedLabels: false,
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
              onTap: context.read<NavControllerDartCubit>().onChangeNavTab,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: AppColors.kWhite,
                  label: "Home",
                  activeIcon: _buildActiveIcon(SolarIconsBold.homeAngle_2),
                  icon: Icon(SolarIconsOutline.homeAngle_2),
                ),
                BottomNavigationBarItem(
                  label: "Home",
                  activeIcon: _buildActiveIcon(SolarIconsBold.lightbulbBold),
                  icon: Icon(SolarIconsOutline.lightbulbBold),
                ),
                BottomNavigationBarItem(
                  label: "Home",
                  activeIcon: _buildActiveIcon(SolarIconsBold.tuning_4),
                  icon: Icon(SolarIconsOutline.tuning_4),
                ),
                BottomNavigationBarItem(
                  label: "Home",
                  activeIcon: _buildActiveIcon(SolarIconsBold.user),
                  icon: Icon(SolarIconsOutline.user),
                ),
              ],
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
