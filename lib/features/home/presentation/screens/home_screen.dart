import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_network_image.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/features/home/data/bloc/dashboard%20controller/dashboard_controller_cubit.dart';
import 'package:bashasagar/features/home/data/models/dashboard_progress_model.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/current_user_pref.dart';
import 'package:bashasagar/core/models/current_user_model.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool isLoadingProfile = true;
  @override
  void initState() {
    super.initState();
    initUi();
    getUserData();
  }

  late CurrentUserModel userModel;
  void getUserData() async {
    userModel = await CurrentUserPref.getUserData;
    isLoadingProfile = false;
    setState(() {});
  }

  bool initializingUI = true;
  late GetUiLanguage getUilang;

  void initUi() async {
    getUilang = await GetUiLanguage.create("DASHBOARD");
    initializingUI = false;
    setState(() {});
    //  if(context.mounted){
    context.read<DashboardControllerCubit>().onFetchDashboardData();
    //  }
  }

  @override
  Widget build(BuildContext context) {
    return initializingUI
        ? AppLoading()
        : Column(
          children: [
            if (!isLoadingProfile)
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${getUilang.uiText(placeHolder: "DAS002")}, ${userModel.name}",
                      style: AppStyle.mediumStyle(
                        color: AppColors.kGrey,
                        fontSize: ResponsiveHelper.fontSmall,
                      ),
                    ),
                    Text(
                      getUilang.uiText(placeHolder: "DAS003"),
                      style: AppStyle.boldStyle(
                        fontSize: ResponsiveHelper.fontMedium,
                      ),
                    ),
                  ],
                ),
              ),
            AppSpacer(hp: .02),

            TextFormField(
              controller: _searchController,
              cursorColor: AppColors.kBlack,
              style: AppStyle.normalStyle(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: ResponsiveHelper.paddingSmall,
                ),
                prefixIcon: Icon(CupertinoIcons.search, color: AppColors.kGrey),
                hintText: getUilang.uiText(placeHolder: "DAS004"),
                hintStyle: AppStyle.normalStyle(color: AppColors.kGrey),
                border: _searchBorder(),
                errorBorder: _searchBorder(),
                enabledBorder: _searchBorder(),
                focusedBorder: _searchBorder(),
                disabledBorder: _searchBorder(),
                focusedErrorBorder: _searchBorder(),
              ),
            ),

            AppSpacer(hp: .01),
            Expanded(
              child: BlocBuilder<
                DashboardControllerCubit,
                DashboardControllerState
              >(
                builder: (context, state) {
                  switch (state) {
                    case DashboardControllerErrorState():
                      {
                        return AppErrorView(error: state.error);
                      }
                    case DashboardControllerSuccessState():
                      {
                        return ListView.separated(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder:
                              (context, index) =>
                                  _buildItem(index, state.languages[index]),
                          separatorBuilder:
                              (context, index) => AppSpacer(hp: .01),
                          itemCount: state.languages.length,
                        );
                      }
                    default:
                      {
                        return AppLoading();
                      }
                  }
                },
              ),
            ),
          ],
        );
  }

  OutlineInputBorder _searchBorder() => OutlineInputBorder(
    borderSide: BorderSide(width: .2),
    borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall),
  );

  Widget _buildItem(int index, DashboardLanguageProgressModel model) {
    final bgColor =
        index.isEven ? AppColors.kSecondary : AppColors.kPrimaryLight;
    return GestureDetector(
      onTap: () {
        context.push(
          primaryCategoryScreen,
          extra: {
            "langaugeId": model.languageId,
            "language": model.details.languageName,
          },
        ).then((value) async{
           await GetUiLanguage.create("DASHBOARD");
        },);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveHelper.paddingLarge,
          horizontal: ResponsiveHelper.paddingXLarge,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: bgColor),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              color: bgColor.withAlpha(120),
            ),
          ],
          color: bgColor.withAlpha(50),
          borderRadius: BorderRadius.circular(
            ResponsiveHelper.borderRadiusXLarge,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      model.details.languageName,
                      style: AppStyle.boldStyle(
                        fontSize: ResponsiveHelper.fontRegular,
                      ),
                    ),
                    Text(
                      "${model.status.totalSecondaryCategories} ${getUilang.uiText(placeHolder: "DAS005")}",
                      style: AppStyle.smallStyle(
                        // fontSize: ResponsiveHelper.fontRegular,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: AppNetworkImage(
                    imageFile: model.details.lanuageImageDark,
                  ),
                ),
              ],
            ),
            AppSpacer(hp: .02),

            LinearProgressIndicator(
              value: model.status.totalCompleted / 100,
              borderRadius: BorderRadius.circular(50),
              color: AppColors.kPrimaryDark,
              backgroundColor: AppColors.kPrimaryDark.withAlpha(120),
            ),
            AppSpacer(hp: .005),
            Align(
              alignment: Alignment.bottomRight,
              child: Text("${model.status.totalCompleted}%",style: AppStyle.smallStyle(),)),
          ],
        ),
      ),
    );
  }
}
