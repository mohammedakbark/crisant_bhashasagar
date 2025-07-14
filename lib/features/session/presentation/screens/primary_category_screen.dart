import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_network_image.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/session/data/bloc/primary%20controller/primary_category_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PrimaryCategoryScreen extends StatefulWidget {
  final String language;
  final String languageId;
  const PrimaryCategoryScreen({
    super.key,
    required this.language,
    required this.languageId,
  });

  @override
  State<PrimaryCategoryScreen> createState() => _PrimaryCategoryScreenState();
}

class _PrimaryCategoryScreenState extends State<PrimaryCategoryScreen> {
  @override
  void initState() {
    context.read<PrimaryCategoryControllerCubit>().onFetchPrimaryCategory(
      widget.languageId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: SizedBox.shrink(),
        ),
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: AppColors.kPrimaryColor,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // AppBackButton(),
                Text(
                  widget.language,
                  style: AppStyle.boldStyle(color: AppColors.kWhite),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveHelper.paddingSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: ResponsiveHelper.wp / 2,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(100),
                      value: .6,
                      color: Colors.amber,
                      backgroundColor: AppColors.kWhite,
                    ),
                  ),
                  AppSpacer(hp: .005),

                  Text(
                    "60%",
                    style: AppStyle.boldStyle(
                      color: AppColors.kWhite,
                      fontSize: ResponsiveHelper.fontExtraSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<
        PrimaryCategoryControllerCubit,
        PrimaryCategoryControllerState
      >(
        builder: (context, state) {
          switch (state) {
            case PrimaryCategoryControllerErrorState():
              {
                return AppErrorView(error: state.error);
              }
            case PrimaryCategoryControllerSuccessState():
              {
                return GridView.builder(
                  padding: EdgeInsets.all(ResponsiveHelper.paddingSmall),
                  itemCount: state.primaryCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: ResponsiveHelper.paddingSmall,
                    mainAxisSpacing: ResponsiveHelper.paddingSmall,
                  ),
                  itemBuilder: (context, index) {
                    final category = state.primaryCategories[index];
                    return GestureDetector(
                      onTap:
                          () => context.push(
                            secondaryCategoryScreen,
                            extra: {
                              "languageId": widget.languageId,
                              "primaryCategoryId": category.primaryCategoryId,
                              "language": widget.language,
                            },
                          ),

                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.kGrey, width: 2),
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.borderRadiusLarge,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              child: AppNetworkImage(
                                imageFile: category.primaryCategoryImage,
                              ),
                            ),
                            AppSpacer(hp: .02),
                            Text(category.primaryCategoryName),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            default:
              {
                return AppLoading();
              }
          }
        },
      ),
    );
  }
}
