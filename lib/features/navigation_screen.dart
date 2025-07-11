import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/home/presentation/screens/home_screen.dart';
import 'package:bashasagar/features/nav_bar.dart';
import 'package:bashasagar/features/profile/presentation/screens/profile_screen.dart';
import 'package:bashasagar/features/search/presentation/screens/search_screen.dart';
import 'package:bashasagar/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});
  final _pages = [
    HomeScreen(),
    SearchScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocBuilder<NavControllerDartCubit, NavControllerDartState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: _pages[state.currentIndex],
          );
        },
      ),
      bottomNavigationBar: AppNavBar(),
    );
  }

  appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: SlideInDown(
        child: SafeArea(
          child: Container(
            height: ResponsiveHelper.hp,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  spreadRadius: -5,
                  color: AppColors.kPrimaryLight.withAlpha(120),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     SolarIconsOutline.hamburgerMenu,
                //     color: AppColors.kBlack,
                //   ),
                // ),
                BlocBuilder<NavControllerDartCubit, NavControllerDartState>(
                  builder: (context, state) {
                    String? title;
                    switch (state.currentIndex) {
                      case 0:
                        title = "home";
                      case 1:
                        title = "quick_search";
                      case 2:
                        title = "settings";
                      case 3:
                        title = "profile";
                    }
                    return Text(
                      title!,
                      style: AppStyle.mediumStyle(color: AppColors.kBlack),
                    );
                  },
                ),

                // IconButton(
                //   onPressed: null,
                //   icon: Icon(
                //     SolarIconsOutline.hamburgerMenu,
                //     color: AppColors.kWhite,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
