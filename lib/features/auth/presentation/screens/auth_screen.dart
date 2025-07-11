import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';

import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:bashasagar/features/auth/presentation/screens/tabs/forget_password.dart';
import 'package:bashasagar/features/auth/presentation/screens/tabs/login.dart';
import 'package:bashasagar/features/auth/presentation/screens/tabs/register.dart';
import 'package:bashasagar/features/auth/presentation/screens/tabs/resent_password.dart';
import 'package:bashasagar/features/auth/presentation/screens/tabs/verify_otp.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.kPrimaryColor,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 39, vertical: 30),
                  color: AppColors.kPrimaryLight,
                ),
              ),

              BlocBuilder<AuthStateControllerCubit, AuthStateControllerState>(
                builder: (context, state) {
                  switch (state.authTab) {
                    case AuthTab.LOGIN:
                      {
                        return Login();
                      }
                    case AuthTab.REGISTER:
                      {
                        return Register();
                      }
                    case AuthTab.VERIFYOTP:
                      {
                        return VerifyOtp();
                      }
                    case AuthTab.FORGETPASSWORD:
                      {
                        return ForgetPassword();
                      }
                    case AuthTab.RESETPASSWORD:
                      {
                        return ResentPassword();
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
