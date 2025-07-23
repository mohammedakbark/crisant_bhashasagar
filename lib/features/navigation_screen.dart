import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/features/home/presentation/screens/home_screen.dart';
import 'package:bashasagar/features/nav_bar.dart';
import 'package:bashasagar/features/profile/presentation/screens/profile_screen.dart';
import 'package:bashasagar/features/search/presentation/screens/search_screen.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:bashasagar/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final _pages = [
    HomeScreen(),
    SearchScreen(),
    SettingsScreen(),
    ProfileScreen(),
  ];

  bool initializingUI = true;
  late GetUiLanguage getUilang;

  void initUi() async {
    getUilang = await GetUiLanguage.create("DASHBOARD");
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
    return Scaffold(
      appBar: initializingUI ? null : _app(),
      body:
          initializingUI
              ? AppLoading()
              : BlocConsumer<NavControllerDartCubit, NavControllerDartState>(
                listener: (context, state) async {
                  if (state.currentIndex == 0) {
                    getUilang = await GetUiLanguage.create("DASHBOARD");
                  }
                  if (state.currentIndex == 1) {
                    getUilang = await GetUiLanguage.create("GLOBALSEARCH");
                  }
                  if (state.currentIndex == 2) {
                    getUilang = await GetUiLanguage.create("SETTINGS");
                  }
                  if (state.currentIndex == 3) {
                    getUilang = await GetUiLanguage.create("PROFILE");
                  }
                },
                builder: (context, state) {
                  return _pages[state.currentIndex];
                },
              ),
      bottomNavigationBar: AppNavBar(),
    );
  }

  AppBar _app() {
    return AppBar(
      backgroundColor: AppColors.kPrimaryColor,

      toolbarHeight: 50,
      surfaceTintColor: AppColors.kWhite,
      title: BlocBuilder<NavControllerDartCubit, NavControllerDartState>(
        builder: (context, navState) {
          return BlocConsumer<
            UiLanguageControllerCubit,
            UiLanguageControllerState
          >(
            builder: (context, langState) {
              String? title;
              switch (navState.currentIndex) {
                case 0:
                  title =
                      getUilang.uiText(placeHolder: "DAS001").isEmpty
                          ? "Home"
                          : getUilang.uiText(placeHolder: "DAS001");
                  break;
                case 1:
                  title =
                      getUilang.uiText(placeHolder: "GLS001").isEmpty
                          ? "Search"
                          : getUilang.uiText(placeHolder: "GLS001");
                  break;
                case 2:
                  title =
                      getUilang.uiText(placeHolder: "SET001").isEmpty
                          ? "Settings"
                          : getUilang.uiText(placeHolder: "SET001");
                  break;
                case 3:
                  title =
                      getUilang.uiText(placeHolder: "PRO001").isEmpty
                          ? "Profile"
                          : getUilang.uiText(placeHolder: "PRO001");
                  break;
              }
              return Text(
                title!,
                style: AppStyle.mediumStyle(
                  fontSize: 18,
                  color: AppColors.kWhite,
                ),
              );
            },
            listener: (context, state) async {
              if (navState.currentIndex == 2) {
                getUilang = await GetUiLanguage.create("SETTINGS");
              }
            },
          );
        },
      ),
    );
  }
}
