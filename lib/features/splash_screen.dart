import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/routes/route_path.dart';
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
      // context.read<UiLanguageControllerCubit>().initGetStartScreen();
      context.go(routeScreen);
    } else {
      context.go(getStartScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
