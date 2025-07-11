import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/controller/localization/localization_controller_cubit.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/profile/presentation/widgets/logout_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomeTextField(
          prefix: Icon(SolarIconsOutline.iPhone),
          lebelText: "Full name",
          width: ResponsiveHelper.wp,
          controller: _nameController,
        ),
        AppSpacer(hp: .02),

        Text(
          textAlign: TextAlign.center,
          "profile_hint",
          style: AppStyle.mediumStyle(color: AppColors.kOrange),
        ),
        AppSpacer(hp: .02),
        CustomeTextField(
          prefix: Icon(SolarIconsOutline.lockKeyhole),
          lebelText: "Password",
          width: ResponsiveHelper.wp,
          controller: _passwordController,
        ),
        AppSpacer(hp: .03),
        CustomeTextField(
          prefix: Icon(SolarIconsOutline.lockKeyhole),
          lebelText: "Repeat Password",
          width: ResponsiveHelper.wp,
          controller: _confirmPasswordController,
        ),

        AppSpacer(hp: .05),
        AppCustomButton(
          width: ResponsiveHelper.wp,
          title: "UPDATE",
          onTap: () {},
        ),

        AppSpacer(hp: .02),
        AppCustomButton(
          bgColor: AppColors.kRed,
          width: ResponsiveHelper.wp,
          title: "LOGOUT",
          onTap: () {
            LogoutBottomSheetHelper.show(
              context,
              onConfirm: () async {
                context.go(initilaScreen);

                context.read<NavControllerDartCubit>().onChangeNavTab(0);
                await CurrentUserPref.clearPref();
              },
              onCancel: () {
                context.pop();
              },
            );
          },
        ),
      ],
    );
  }
}
