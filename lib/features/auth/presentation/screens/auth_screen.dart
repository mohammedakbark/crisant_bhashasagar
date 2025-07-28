import 'package:bashasagar/core/const/appcolors.dart';
 import 'package:bashasagar/core/enums/auth_tab.dart';

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
      backgroundColor:  //   height: ResponsiveHelper.hp,
   AppColors.kPrimaryColor,
      // body: Container(
      //   height: ResponsiveHelper.hp,
      //   color: AppColors.kPrimaryColor,
      //   child: Stack(
      //   // fit: StackFit.expand,
      //   alignment: Alignment.bottomCenter,
      //     children: [
      //       Positioned(
      //         left: 10,
      //         right: 10,
      //         top: ResponsiveHelper.hp*.2,
      //         child: SafeArea(
      //           child: BlocBuilder<AuthStateControllerCubit, AuthStateControllerState>(
      //             builder: (context, state) {
      //               return Container(
      //                 width: ResponsiveHelper.wp,
      //                 margin: EdgeInsets.symmetric(
      //                   horizontal: 39,
      //                 ),

      //                 child: Image.asset(
      //                   state.authTab == AuthTab.VERIFYOTP
      //                       ? ImgConst.verify
      //                       : ImgConst.login,
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ),

      //       // Spacer(),
      //       Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           BlocBuilder<
      //             AuthStateControllerCubit,
      //             AuthStateControllerState
      //           >(
      //             builder: (context, state) {
      //               switch (state.authTab) {
      //                 case AuthTab.LOGIN:
      //                   {
      //                     return Login();
      //                   }
      //                 case AuthTab.REGISTER:
      //                   {
      //                     return Register();
      //                   }
      //                 case AuthTab.VERIFYOTP:
      //                   {
      //                     return VerifyOtp();
      //                   }
      //                 case AuthTab.FORGETPASSWORD:
      //                   {
      //                     return ForgetPassword();
      //                   }
      //                 case AuthTab.RESETPASSWORD:
      //                   {
      //                     return ResentPassword();
      //                   }
      //               }
      //             },
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      body: BlocBuilder<AuthStateControllerCubit, AuthStateControllerState>(
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
    );
  }
}
