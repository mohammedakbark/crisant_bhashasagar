import 'package:bashasagar/core/controller/localization/localization_controller_cubit.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:bashasagar/features/settings/data/bloc/language%20selection%20controller/language_selection_controller_cubit.dart';
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

        BlocProvider<LanguageSelectionControllerCubit>(
          create: (context) => LanguageSelectionControllerCubit(),
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
      ],
      child: child,
    );
  }
}
