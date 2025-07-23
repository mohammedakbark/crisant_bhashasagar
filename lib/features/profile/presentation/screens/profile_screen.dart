import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custome_textfield.dart';
import 'package:bashasagar/features/profile/data/bloc/profiel%20state%20controller/profile_state_controller_cubit.dart';
import 'package:bashasagar/features/session/data/bloc/content%20controller/content_controller_bloc.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/controller/nav%20controller/nav_controller_dart_cubit.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/profile/presentation/widgets/logout_sheet.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  void onLogout(BuildContext context) async {
    await UiLanguageControllerCubit.clearAll();
    await ContentControllerBloc.deleteEntireContentFromBashasagar();
    await CurrentUserPref.clearPref();
    context.read<NavControllerDartCubit>().onChangeNavTab(0);
    context.go(initilaScreen);
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        initUi();
        if (mounted) {
          context.read<AuthApiControllerBloc>().add(
            OnGetProfileInfo(storeData: true),
          );
        }
      } catch (e) {
        initializingUI = false;
        setState(() {});
      }
    });

    super.initState();
    Future.microtask(() {});
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
        : Center(
          child: SingleChildScrollView(
            child: AppMargin(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<AuthApiControllerBloc, AuthApiControllerState>(
                    builder: (context, state) {
                      if (state is AuthApiFetchProfileState) {
                        _nameController.text = state.profileModel.customerName;
                        _emailController.text =
                            state.profileModel.customerEmailAddress;
                        _genderController.text =
                            state.profileModel.customerGender;
                        _ageController.text = state.profileModel.customerAge;
                        _addressController.text =
                            state.profileModel.customerAddress;
                        return Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              AppSpacer(hp: .03),
                              CustomeTextField(
                                prefix: Icon(Icons.person_2),
                                lebelText: getUilang.uiText(
                                  placeHolder: "PRO002",
                                ),
                                width: ResponsiveHelper.wp,
                                controller: _nameController,
                              ),
                              AppSpacer(hp: .02),
                              CustomeTextField(
                                prefix: Icon(Icons.mail),
                                lebelText: getUilang.uiText(
                                  placeHolder: "PRO003",
                                ),
                                width: ResponsiveHelper.wp,
                                controller: _emailController,
                              ),
                              AppSpacer(hp: .02),
                              DropdownButtonFormField2<String>(
                                isExpanded: true,
                                value:
                                    _genderController.text.isEmpty
                                        ? null
                                        : _genderController.text,
                                items:
                                    ["Male", "Female", "Other"].map((gender) {
                                      return DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(
                                          gender,
                                          style: AppStyle.normalStyle(),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  _genderController.text = value ?? "";
                                },
          
                                dropdownStyleData: DropdownStyleData(
                                  useSafeArea: true,
                                  decoration: BoxDecoration(
                                    color: AppColors.kWhite,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  hintText: "Select gender",
                                  hintStyle: AppStyle.normalStyle(
                                    color: AppColors.kGrey,
                                    fontSize: ResponsiveHelper.fontSmall,
                                  ),
                                  labelText: getUilang.uiText(
                                    placeHolder: "PRO004",
                                  ),
                                  labelStyle: AppStyle.normalStyle(
                                    color: AppColors.kGrey,
                                    fontSize: ResponsiveHelper.fontSmall,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: AppColors.kGrey,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: AppColors.kGrey,
                                  ),
          
                                  enabledBorder: border(),
                                  focusedBorder: border(),
                                  errorBorder: border(color: AppColors.kRed),
                                  focusedErrorBorder: border(
                                    color: AppColors.kRed,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              AppSpacer(hp: .02),
                              TextField(
                                controller: _ageController,
                                keyboardType: TextInputType.number,
                                style: AppStyle.normalStyle(),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  enabledBorder: border(),
                                  focusedBorder: border(),
                                  errorBorder: border(color: AppColors.kRed),
                                  focusedErrorBorder: border(
                                    color: AppColors.kRed,
                                  ),
                                  labelText: getUilang.uiText(
                                    placeHolder: "PRO005",
                                  ),
                                  labelStyle: AppStyle.normalStyle(
                                    color: AppColors.kGrey,
                                    fontSize: ResponsiveHelper.fontSmall,
                                  ),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.cake,
                                    color: AppColors.kGrey,
                                  ),
          
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.remove,
                                          color: AppColors.kGrey,
                                        ),
                                        onPressed: () {
                                          int currentAge =
                                              int.tryParse(_ageController.text) ??
                                              0;
                                          if (currentAge > 0) {
                                            currentAge--;
                                            _ageController.text =
                                                currentAge.toString();
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: AppColors.kGrey,
                                        ),
                                        onPressed: () {
                                          int currentAge =
                                              int.tryParse(_ageController.text) ??
                                              0;
                                          currentAge++;
                                          _ageController.text =
                                              currentAge.toString();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
          
                              AppSpacer(hp: .02),
                              CustomeTextField(
                                prefix: Icon(Icons.location_on),
                                lebelText: getUilang.uiText(
                                  placeHolder: "PRO006",
                                ),
                                width: ResponsiveHelper.wp,
                                controller: _addressController,
                              ),
                              AppSpacer(hp: .02),
          
                              Text(
                                textAlign: TextAlign.center,
                                getUilang.uiText(placeHolder: "PRO007"),
                                style: AppStyle.mediumStyle(
                                  color: AppColors.kOrange,
                                ),
                              ),
                              AppSpacer(hp: .02),
                              CustomeTextField(
                                validator: (p0) {
                                  if (_confirmPasswordController
                                      .text
                                      .isNotEmpty) {
                                    if (p0!.isEmpty) {
                                      return "This field is required";
                                    }
                                  }
                                  return null;
                                },
                                prefix: Icon(SolarIconsOutline.lockKeyhole),
                                lebelText: getUilang.uiText(
                                  placeHolder: "PRO008",
                                ),
                                width: ResponsiveHelper.wp,
                                controller: _passwordController,
                              ),
                              AppSpacer(hp: .03),
                              CustomeTextField(
                                validator: (p0) {
                                  if (_passwordController.text.isNotEmpty) {
                                    if (p0!.isEmpty) {
                                      return "This field is required";
                                    }
                                    if (p0 != _passwordController.text) {
                                      return "Password do not match";
                                    }
                                  }
                                  return null;
                                },
                                prefix: Icon(SolarIconsOutline.lockKeyhole),
                                lebelText: getUilang.uiText(
                                  placeHolder: "PRO009",
                                ),
                                width: ResponsiveHelper.wp,
                                controller: _confirmPasswordController,
                              ),
          
                              AppSpacer(hp: .05),
                              BlocBuilder<
                                ProfileStateControllerCubit,
                                ProfileStateControllerState
                              >(
                                builder: (context, state) {
                                  return AppCustomButton(
                                    isLoading:
                                        state
                                            is ProfileStateControllerUpdateLoadingState,
                                    width: ResponsiveHelper.wp,
                                    title: getUilang.uiText(
                                      placeHolder: "PRO010",
                                    ),
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final name = _nameController.text;
                                        final gender = _genderController.text;
                                        final age = _ageController.text;
                                        final email = _emailController.text;
                                        final address = _addressController.text;
                                        final password =
                                            _passwordController.text.isEmpty
                                                ? null
                                                : _passwordController.text;
                                        final confirmPassword =
                                            _confirmPasswordController
                                                    .text
                                                    .isEmpty
                                                ? null
                                                : _confirmPasswordController.text;
                                        await context
                                            .read<ProfileStateControllerCubit>()
                                            .onUpdateProfile(
                                              context,
                                              name,
                                              gender,
                                              email,
                                              address,
                                              age,
                                              password,
                                              confirmPassword,
                                            );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (state is AuthApiControllerErrorState) {
                        return Center(child: AppErrorView(error: state.error));
                      } else {
                        return Center(child: AppLoading());
                      }
                    },
                  ),
          
                  AppSpacer(hp: .02),
                  if (context.watch<AuthApiControllerBloc>().state
                      is !AuthApiControllerLoadingState)
                    AppCustomButton(
                      bgColor: AppColors.kRed,
                      width: ResponsiveHelper.wp,
                      title: "Logout",
                      onTap: () {
                        LogoutBottomSheetHelper.show(
                          context,
                          onConfirm: () => widget.onLogout(context),
                          onCancel: () {
                            context.pop();
                          },
                        );
                      },
                    ),
          
                  AppSpacer(hp: .03),
                ],
              ),
            ),
          ),
        );
  }

  InputBorder border({Color? color}) => OutlineInputBorder(
    borderSide: BorderSide(width: .6, color: color ?? AppColors.kGrey),
    borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall),
  );
}
