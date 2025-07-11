import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:flutter/material.dart';
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
