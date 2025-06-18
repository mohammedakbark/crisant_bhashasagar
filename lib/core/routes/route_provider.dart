import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/features/auth/presentation/screens/get_start_screen.dart';
import 'package:bashasagar/features/auth/presentation/screens/auth_screen.dart';
import 'package:bashasagar/features/auth/presentation/screens/registration_screen.dart';
import 'package:bashasagar/features/navigation_screen.dart';
import 'package:bashasagar/features/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class RouteProvider {
  static GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initilaScreen,
    routes: [
      GoRoute(
        path: initilaScreen,
        builder: (context, state) => GetStartScreen(),
      ),
      GoRoute(
        path: getStartScreen,
        builder: (context, state) => GetStartScreen(),
      ),
      GoRoute(path: authScreen, builder: (context, state) => AuthScreen()),

      GoRoute(
        path: authSuccessScreen,
        builder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          final String successTitle = params['successTitle'];
          final String successMessage = params['successMessage'];
          final String buttonTitle = params['buttonTitle'];
          final String buttonAction = params['nextScreen'];
          return AuthSuccessScreen(
            nextScreen: buttonAction,
            buttonTitle: buttonTitle,
            successMessage: successMessage,
            successTitle: successTitle,
          );
        },
      ),

        GoRoute(path: routeScreen, builder: (context, state) => NavigationScreen()),
    ],
  );
}
