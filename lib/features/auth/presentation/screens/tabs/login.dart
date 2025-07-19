import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_response_text.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/core/const/img_const.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/core/utils/validators.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginMobileController = TextEditingController();

  final _loginPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initUi();
    super.initState();
  }

  bool initializingUI = true;
  late GetUiLanguage getUilang;

  void initUi() async {
    getUilang = await GetUiLanguage.create("LOGIN");
    initializingUI = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: ResponsiveHelper.hp * .1,
          left: 10,
          right: 10,
          child: SafeArea(child: Image.asset(ImgConst.login)),
        ),
        Positioned(
          bottom: 0,
          child:
              initializingUI
                  ? AppLoading()
                  : FadeIn(
                    child: Container(
                      width: ResponsiveHelper.wp,
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ResponsiveHelper.borderRadiusLarge,
                          ),
                          topRight: Radius.circular(
                            ResponsiveHelper.borderRadiusLarge,
                          ),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: AppMargin(
                          child: Column(
                            children: [
                              Text(
                                getUilang
                                    .uiText(placeHolder: "LOG005")
                                    .toUpperCase(),
                                style: AppStyle.mediumStyle(
                                  fontSize: ResponsiveHelper.fontLarge,
                                ),
                              ),
                              AppSpacer(hp: .03),
                              CustomeTextField(
                                keyboardType: TextInputType.number,
                                prefix: Icon(SolarIconsOutline.phone),
                                lebelText: getUilang.uiText(
                                  placeHolder: "LOG002",
                                ),
                                controller: _loginMobileController,
                                validator: AppValidator.mobileNumberValidator,
                              ),
                              AppSpacer(hp: .03),
                              CustomeTextField(
                                isObsecure: true,
                                prefix: Icon(SolarIconsOutline.lock),
                                lebelText: getUilang.uiText(
                                  placeHolder: "LOG003",
                                ),
                                controller: _loginPasswordController,
                                validator: AppValidator.requiredValidator,
                              ),
                              AppSpacer(hp: .01),
                              BlocBuilder<
                                AuthApiControllerBloc,
                                AuthApiControllerState
                              >(
                                builder: (context, state) {
                                  if (state is AuthApiControllerErrorState) {
                                    return AppResponseText(message: state.error);
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<AuthStateControllerCubit>()
                                          .onChangeAuthTab(
                                            AuthTab.FORGETPASSWORD,
                                          );
                                    },
                                    child: Text(
                                      getUilang.uiText(placeHolder: "LOG004"),
                                      style: AppStyle.normalStyle(),
                                    ),
                                  ),
                                ],
                              ),
                    
                              AppSpacer(hp: .01),
                              BlocBuilder<
                                AuthApiControllerBloc,
                                AuthApiControllerState
                              >(
                                builder: (context, state) {
                                  return AppCustomButton(
                                    isLoading:
                                        state is AuthApiControllerLoadingState,
                                    title: getUilang.uiText(
                                      placeHolder: "LOG005",
                                    ),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthApiControllerBloc>().add(
                                          OnLogin(
                                            context: context,
                                            mobileNumber:
                                                _loginMobileController.text
                                                    .trim(),
                                            password:
                                                _loginPasswordController.text
                                                    .trim(),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                              AppSpacer(hp: .02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getUilang.uiText(placeHolder: "LOG006"),
                                    style: AppStyle.normalStyle(),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<AuthStateControllerCubit>()
                                          .onChangeAuthTab(AuthTab.REGISTER);
                                    },
                                    child: Text(
                                      getUilang.uiText(placeHolder: "LOG007"),
                                      style: AppStyle.boldStyle(
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}
