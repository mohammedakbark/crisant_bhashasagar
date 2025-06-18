import 'package:bashasagar/features/auth/data/bloc/cubit/auth_state_controller_cubit.dart';
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
      ],
      child: child,
    );
  }
}
