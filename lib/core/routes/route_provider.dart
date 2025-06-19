import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/features/auth/presentation/screens/get_start_screen.dart';
import 'package:bashasagar/features/auth/presentation/screens/auth_screen.dart';
import 'package:bashasagar/features/auth/presentation/screens/auth_success_screen.dart';
import 'package:bashasagar/features/auth/presentation/screens/welcome_screen.dart';
import 'package:bashasagar/features/home/presentation/screens/learning_path_screen.dart';
import 'package:bashasagar/features/home/presentation/screens/topic_list_screen.dart';
import 'package:bashasagar/features/home/presentation/screens/visual_learning_screen.dart';
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
        builder: (context, state) => NavigationScreen(),
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
          final AuthTab nextAuthTab = params['nextAuthTab'];
          return AuthSuccessScreen(
            nextAuthTab: nextAuthTab,
            buttonTitle: buttonTitle,
            successMessage: successMessage,
            successTitle: successTitle,
          );
        },
      ),

      GoRoute(
        path: welcomeScreen,
        builder: (context, state) => WelcomeScreen(),
      ),
      //---D A S H B O R D
      GoRoute(
        path: routeScreen,
        builder: (context, state) => NavigationScreen(),
      ),
      //--- --- --- ---
      GoRoute(
        path: learningPathScreen,
        builder: (context, state) {
          final body = state.extra as Map<String, dynamic>;
          final language = body['language'];
          return LearningPathScreen(language: language);
        },
      ),
      GoRoute(
        path: topicListScreen,
        builder: (context, state) {
          final body = state.extra as Map<String, dynamic>;
          final language = body['language'];
          return TopicListScreen(language: language);
        },
      ),
      GoRoute(
        path: visualLearningScreen,
       builder: (context, state) {
          final body = state.extra as Map<String, dynamic>;
          final language = body['language'];
          return VisualLearningScreen(language: language);
        },
      ),
    ],
  );
}
