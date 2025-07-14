import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/profile/presentation/widgets/logout_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();
  @override
  void initState() {
    initUi();

    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<AuthApiControllerBloc>().add(
          OnGetProfileInfo(storeData: true),
        );
      }
    });
  }

  bool initializingUI = true;
  late GetUiLanguage getUilang;

  void initUi() async {
    getUilang = await GetUiLanguage.create("PROFILE");
    initializingUI = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return initializingUI
        ? AppLoading()
        : BlocBuilder<AuthApiControllerBloc, AuthApiControllerState>(
          builder: (context, state) {
            if (state is AuthApiFetchProfileState) {
              _nameController.text = state.profileModel.userinfo.customerName;
              return Column(
                children: [
                  CustomeTextField(
                    prefix: Icon(Icons.person_2),
                    lebelText: getUilang.uiText(placeHolder: "PRO002"),
                    width: ResponsiveHelper.wp,
                    controller: _nameController,
                  ),
                  AppSpacer(hp: .02),
                  CustomeTextField(
                    prefix: Icon(Icons.mail),
                    lebelText: getUilang.uiText(placeHolder: "PRO003"),
                    width: ResponsiveHelper.wp,
                    controller: _emailController,
                  ),
                  AppSpacer(hp: .02),
                  Row(
                    children: [
                      Flexible(
                        child: CustomeTextField(
                          prefix: Icon(Icons.person),
                          lebelText: getUilang.uiText(placeHolder: "PRO004"),
                          width: ResponsiveHelper.wp,
                          controller: _genderController,
                        ),
                      ),
                      AppSpacer(wp: .04),
                      Flexible(
                        child: CustomeTextField(
                          prefix: Icon(Icons.cake),
                          lebelText: getUilang.uiText(placeHolder: "PRO005"),
                          width: ResponsiveHelper.wp,
                          controller: _ageController,
                        ),
                      ),
                    ],
                  ),
                  AppSpacer(hp: .02),
                  CustomeTextField(
                    prefix: Icon(Icons.location_on),
                    lebelText: getUilang.uiText(placeHolder: "PRO006"),
                    width: ResponsiveHelper.wp,
                    controller: _addressController,
                  ),
                  AppSpacer(hp: .02),

                  Text(
                    textAlign: TextAlign.center,
                    getUilang.uiText(placeHolder: "PRO007"),
                    style: AppStyle.mediumStyle(color: AppColors.kOrange),
                  ),
                  AppSpacer(hp: .02),
                  CustomeTextField(
                    prefix: Icon(SolarIconsOutline.lockKeyhole),
                    lebelText: getUilang.uiText(placeHolder: "PRO008"),
                    width: ResponsiveHelper.wp,
                    controller: _passwordController,
                  ),
                  AppSpacer(hp: .03),
                  CustomeTextField(
                    prefix: Icon(SolarIconsOutline.lockKeyhole),
                    lebelText: getUilang.uiText(placeHolder: "PRO009"),
                    width: ResponsiveHelper.wp,
                    controller: _confirmPasswordController,
                  ),

                  AppSpacer(hp: .05),
                  AppCustomButton(
                    width: ResponsiveHelper.wp,
                    title: getUilang.uiText(placeHolder: "PRO010"),
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

                          context.read<NavControllerDartCubit>().onChangeNavTab(
                            0,
                          );
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
            } else if (state is AuthApiControllerErrorState) {
              return AppErrorView(error: state.error);
            } else {
              return AppLoading();
            }
          },
        );
  }
}
