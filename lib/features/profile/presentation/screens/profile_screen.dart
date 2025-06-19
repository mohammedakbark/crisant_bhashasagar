import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
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
          "If you do not wish to change your password\nleave the below fields empty",
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
      ],
    );
  }
}
