
import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/nav_bar.dart';
import 'package:bashasagar/features/session/data/bloc/secondary%20controller/secondary_category_controllr_cubit.dart';
import 'package:bashasagar/features/session/presentation/widgets/secondary_cat_grid_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SecondaryCategoryScreen extends StatefulWidget {
  final String language;
  final String langId;
  final String primaryCategoryId;
  final String primaryCategory;

  const SecondaryCategoryScreen({
    super.key,
    required this.language,
    required this.langId,
    required this.primaryCategory,
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
        toolbarHeight: 50,

        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: AppColors.kPrimaryColor,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.language,
              style: AppStyle.boldStyle(color: AppColors.kWhite),
            ),
            Text(
              widget.primaryCategory,
              style: AppStyle.boldStyle(
                color: AppColors.kWhite.withAlpha(150),
                fontSize: 10,
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

                    return SecondaryCatGridTitle(
                      index: index,
                      isSelected:
                          state.currentIndex == null
                              ? false
                              : index == state.currentIndex,
                      language: widget.language,
                      primaryCategory: widget.primaryCategory,
                      primaryCategoryId: widget.primaryCategoryId,
                      secondaryCategory: category.secondaryCategoryName,
                      secondaryCategoryId: category.secondaryCategoryId,
                      secondaryCategoryImage: category.secondaryCategoryImage,
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
      bottomNavigationBar: AppNavBar(
        onTap: (p0) {
          context.go(routeScreen);
        },
      ),
    );
  }

  // void _showDeleteDiologe(String secondaryCategoryId) {
  //   showDialog(
  //     context: context,
  //     builder:
  //         (context) => AlertDialog.adaptive(
  //           backgroundColor: AppColors.kWhite,
  //           title: Text(
  //             "Do you want to delete this content ?",
  //             style: AppStyle.mediumStyle(
  //               color: Platform.isAndroid ? AppColors.kBlack : AppColors.kWhite,
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 context.pop();
  //               },
  //               child: Text(
  //                 "No",
  //                 style: AppStyle.mediumStyle(color: AppColors.kGrey),
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () async {
  //                 context.read<ContentControllerBloc>().add(
  //                   DeleteContentById(
  //                     secondaryCategoryId: secondaryCategoryId,
  //                     primaryCategoryId: widget.primaryCategoryId,
  //                   ),
  //                 );

  //                 context.pop();
  //               },
  //               child: Text(
  //                 "Yes",
  //                 style: AppStyle.mediumStyle(color: AppColors.kRed),
  //               ),
  //             ),
  //           ],
  //         ),
  //   );
  // }
}
