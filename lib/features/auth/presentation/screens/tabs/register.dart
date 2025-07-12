import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_response_text.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/core/config/language/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/enums/auth_tab.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/core/utils/validators.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20state%20controller/auth_state_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _regNameController = TextEditingController();

  final _regMobileController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

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
    return SlideInUp(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: ResponsiveHelper.wp,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ResponsiveHelper.borderRadiusLarge),
            topRight: Radius.circular(ResponsiveHelper.borderRadiusLarge),
          ),
        ),
        child: Form(
          key: _formKey,
          child: AppMargin(
            child: Column(
              children: [
                Text(
                  "NEW USER",
                  style: AppStyle.mediumStyle(
                    fontSize: ResponsiveHelper.fontLarge,
                  ),
                ),
                AppSpacer(hp: .03),
                CustomeTextField(
                  prefix: Icon(SolarIconsOutline.user),
                  lebelText: "Full name",
                  controller: _regNameController,
                  validator: AppValidator.requiredValidator,
                ),
                AppSpacer(hp: .02),
                CustomeTextField(
                  prefix: Icon(SolarIconsOutline.phone),
                  keyboardType: TextInputType.number,
                  lebelText: "Mobile number",
                  controller: _regMobileController,
                  validator: AppValidator.mobileNumberValidator,
                ),
                AppSpacer(hp: .02),
                CustomeTextField(
                  isObsecure: true,
                  prefix: Icon(SolarIconsOutline.lock),
                  lebelText: 'Password',
                  controller: _passwordController,
                  validator: AppValidator.requiredValidator,
                ),
                AppSpacer(hp: .02),
                CustomeTextField(
                  isObsecure: true,
                  prefix: Icon(SolarIconsOutline.lock),
                  lebelText: 'Repeat Password',
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field is required";
                    }
                    if (value != _passwordController.text.trim()) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                AppSpacer(hp: .01),
                BlocBuilder<AuthApiControllerBloc, AuthApiControllerState>(
                  builder: (context, state) {
                    if (state is AuthApiControllerErrorState) {
                      return AppResponseText(message: state.error);
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
                AppSpacer(hp: .04),

                BlocBuilder<AuthApiControllerBloc, AuthApiControllerState>(
                  builder: (context, state) {
                    return AppCustomButton(
                      isLoading: state is AuthApiControllerLoadingState,
                      title: "REGISTER",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthApiControllerBloc>().add(
                            OnRegister(
                              context: context,
                              mobileNumber: _regMobileController.text.trim(),
                              password: _passwordController.text.trim(),
                              confirmPassword:
                                  _confirmPasswordController.text.trim(),
                              customerName: _regNameController.text.trim(),
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
                    Text("Back to", style: AppStyle.normalStyle()),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthStateControllerCubit>()
                            .onChangeAuthTab(AuthTab.LOGIN);
                      },
                      child: Text(
                        "Login",
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
    );
  }
}
