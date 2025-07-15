import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:bashasagar/features/home/data/bloc/dashboard%20controller/dashboard_controller_cubit.dart';
import 'package:bashasagar/features/session/data/bloc/content%20controller/content_controller_bloc.dart';
import 'package:bashasagar/features/session/data/bloc/primary%20controller/primary_category_controller_cubit.dart';
import 'package:bashasagar/features/session/data/bloc/secondary%20controller/secondary_category_controllr_cubit.dart';
import 'package:bashasagar/features/settings/data/bloc/learn%20lang%20controller/learn_lang_selection_controller_cubit.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // return child;
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthStateControllerCubit>(
          create: (context) => AuthStateControllerCubit(),
        ),

        BlocProvider<LearnLangControllerCubit>(
          create: (context) => LearnLangControllerCubit(),
        ),
        BlocProvider<NavControllerDartCubit>(
          create: (context) => NavControllerDartCubit(),
        ),
        // BlocProvider<LocalizationControllerCubit>(
        //   create: (context) => LocalizationControllerCubit(),
        // ),
        BlocProvider<AuthApiControllerBloc>(
          create: (context) => AuthApiControllerBloc(),
        ),
        BlocProvider<UiLanguageControllerCubit>(
          create: (context) => UiLanguageControllerCubit(),
        ),
        BlocProvider<DashboardControllerCubit>(
          create: (context) => DashboardControllerCubit(),
        ),
        BlocProvider<PrimaryCategoryControllerCubit>(
          create: (context) => PrimaryCategoryControllerCubit(),
        ),

        BlocProvider<SecondaryCategoryControllrCubit>(
          create: (context) => SecondaryCategoryControllrCubit(),
        ),
        BlocProvider<ContentControllerBloc>(
          create: (context) => ContentControllerBloc(),
        ),
      ],
      child: child,
    );
  }
}
