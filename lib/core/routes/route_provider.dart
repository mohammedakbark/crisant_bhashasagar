import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/features/auth/presentation/screens/get_start_screen.dart';
import 'package:bashasagar/features/auth/presentation/screens/auth_screen.dart';
import 'package:bashasagar/features/auth/presentation/screens/auth_success_screen.dart';
import 'package:bashasagar/features/auth/presentation/screens/welcome_screen.dart';
import 'package:bashasagar/features/session/presentation/screens/primary_category_screen.dart';
import 'package:bashasagar/features/session/presentation/screens/secondary_category_screen.dart';
import 'package:bashasagar/features/session/presentation/screens/visual_learning_screen.dart';
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
        pageBuilder: (context, state) => _slideTransitionPage(SplashScreen()),
      ),
      GoRoute(
        path: getStartScreen,
        builder: (context, state) => GetStartScreen(),
      ),
      GoRoute(
        path: authScreen,
        pageBuilder: (context, state) => _slideTransitionPage(AuthScreen()),
      ),

      GoRoute(
        path: authSuccessScreen,
        pageBuilder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          final String successTitle = params['successTitle'];
          final String successMessage = params['successMessage'];
          final String buttonTitle = params['buttonTitle'];
          final AuthTab nextAuthTab = params['nextAuthTab'];
          return _slideTransitionPage(
            AuthSuccessScreen(
              nextAuthTab: nextAuthTab,
              buttonTitle: buttonTitle,
              successMessage: successMessage,
              successTitle: successTitle,
            ),
          );
        },
      ),

      GoRoute(
        path: welcomeScreen,
        pageBuilder: (context, state) => _slideTransitionPage(WelcomeScreen()),
      ),
      //---D A S H B O R D
      GoRoute(
        path: routeScreen,
        pageBuilder:
            (context, state) => _slideTransitionPage(NavigationScreen()),
      ),
      //--- --- --- ---
      GoRoute(
        path: primaryCategoryScreen,
        pageBuilder: (context, state) {
          final body = state.extra as Map<String, dynamic>;
          final language = body['language'];
          final id = body['langaugeId'];
          return _slideTransitionPage(
            PrimaryCategoryScreen(language: language, languageId: id),
          );
        },
      ),
      GoRoute(
        path: secondaryCategoryScreen,
        pageBuilder: (context, state) {
          final body = state.extra as Map<String, dynamic>;
          final language = body['language'];
          final langId = body["languageId"];
          final primaryCategoryId = body["primaryCategoryId"];
          final primaryCategory = body['primaryCategory'];
          return _slideTransitionPage(
            SecondaryCategoryScreen(
              primaryCategory: primaryCategory,
              language: language,
              langId: langId,
              primaryCategoryId: primaryCategoryId,
            ),
          );
        },
      ),
      GoRoute(
        path: contentScreen,
        pageBuilder: (context, state) {
          final body = state.extra as Map<String, dynamic>;
          final language = body['language'];
          final primaryCategoryId = body["primaryCategoryId"];
          final seocndaryCategoryId = body["secondaryCategoryId"];
          final primaryCategoryAndSecondaryCategory =
              body['primaryCategoryAndSecondaryCategory'];
          return _slideTransitionPage(
            ContentScreen(
              language: language,
              primaryCategoryId: primaryCategoryId,
              secondaryCategoryId: seocndaryCategoryId,
              primaryCategoryAndSecondaryCategory:
                  primaryCategoryAndSecondaryCategory,
            ),
          );
        },
      ),
    ],
  );
  // ==== TRANSITION
  static CustomTransitionPage<dynamic> _slideTransitionPage(Widget child) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // from right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
