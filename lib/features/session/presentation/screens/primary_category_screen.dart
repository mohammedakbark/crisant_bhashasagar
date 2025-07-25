import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_network_image.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/nav_bar.dart';
import 'package:bashasagar/features/session/data/bloc/primary%20controller/primary_category_controller_cubit.dart';
import 'package:bashasagar/features/session/presentation/widgets/primary_cat_gird_title.dart';
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
        toolbarHeight: 50,

        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: AppColors.kPrimaryColor,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.language,
                  style: AppStyle.boldStyle(color: AppColors.kWhite),
                ),
              ],
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

                    return PrimaryCatGirdTitle(
                      index: index,
                      isSelected:
                          state.currentIndex == null
                              ? false
                              : index == state.currentIndex,
                      language: widget.language,
                      languageId: widget.languageId,
                      primaryCategoryId: category.primaryCategoryId,
                      primaryCategoryImage: category.primaryCategoryImage,
                      primaryCategoryName: category.primaryCategoryName,
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
}
