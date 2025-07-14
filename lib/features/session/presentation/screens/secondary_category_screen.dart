import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_network_image.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/session/data/bloc/primary%20controller/primary_category_controller_cubit.dart';
import 'package:bashasagar/features/session/data/bloc/secondary%20controller/secondary_category_controllr_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SecondaryCategoryScreen extends StatefulWidget {
  final String language;
  final String langId;
  final String primaryCategoryId;

  const SecondaryCategoryScreen({
    super.key,
    required this.language,
    required this.langId,
    required this.primaryCategoryId,
  });

  @override
  State<SecondaryCategoryScreen> createState() =>
      _SecondaryCategoryScreenState();
}

class _SecondaryCategoryScreenState extends State<SecondaryCategoryScreen> {
  @override
  void initState() {
    context.read<SecondaryCategoryControllrCubit>().onFetchSecondaryCategory(
      widget.primaryCategoryId,
      widget.langId,
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
        SecondaryCategoryControllrCubit,
        SecondaryCategoryControllrState
      >(
        builder: (context, state) {
          switch (state) {
            case SecondaryCategoryControllerErrorState():
              {
                return AppErrorView(error: state.error);
              }
            case SecondaryCategoryControllerSuccessState():
              {
                return GridView.builder(
                  padding: EdgeInsets.all(ResponsiveHelper.paddingSmall),
                  itemCount: state.secondaryCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: ResponsiveHelper.paddingSmall,
                    mainAxisSpacing: ResponsiveHelper.paddingSmall,
                  ),
                  itemBuilder: (context, index) {
                    final category = state.secondaryCategories[index];
                    return GestureDetector(
                      onTap:
                          () => context.push(
                            visualLearningScreen,
                            extra: {"language": widget.language},
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
                                imageFile: category.secondaryCategoryImage,
                              ),
                            ),
                            AppSpacer(hp: .02),
                            Text(
                              category.secondaryCategoryName,
                              textAlign: TextAlign.center,
                            ),
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
