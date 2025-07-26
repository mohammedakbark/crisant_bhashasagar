import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/const/img_const.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/notification/data/notification_service.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    takeDecisionToNext();
    super.initState();
  }

  void takeDecisionToNext() async {
    final currentUser = await CurrentUserPref.getUserData;

    if (currentUser.token != null && currentUser.token!.isNotEmpty) {
      await Future.delayed(Duration(seconds: 1));
      NotificationService().initNotification(context);
      context.go(routeScreen);
    } else {
      await context.read<UiLanguageControllerCubit>().initGetStartScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UiLanguageControllerCubit, UiLanguageControllerState>(
        listener: (context, state) {
          if (state is UiLanguageControllerSuccessState) {
            context.go(getStartScreen);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSpacer(hp: .05),
                Spacer(),
                SizedBox(
                  width: ResponsiveHelper.wp,
                  height: ResponsiveHelper.hp * .5,
                  child: Image.asset(fit: BoxFit.contain, ImgConst.appLogo),
                ),
                Spacer(),
                AppLoading(),
                AppSpacer(hp: .02),
                if (state is UiLanguageControllerLoadingState) ...[
                  Text(
                    state.loadingFor,
                    style: AppStyle.mediumStyle(
                      fontSize: 10,
                      color: AppColors.kGrey,
                    ),
                  ),
                ],

                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     AppLoading(),
                //     AppSpacer(hp: .02),
                //     Text(
                //       "Downloading...",
                //       style: AppStyle.mediumStyle(
                //         fontSize: 10,
                //         color: AppColors.kGrey,
                //       ),
                //     ),
                //   ],
                // ),
                AppSpacer(hp: .05),
              ],
            ),
          );
        },
      ),
    );
  }
}
