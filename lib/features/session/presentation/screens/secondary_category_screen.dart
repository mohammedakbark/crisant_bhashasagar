import 'dart:io';

import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_network_image.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/nav_bar.dart';
import 'package:bashasagar/features/session/data/bloc/content%20controller/content_controller_bloc.dart';
import 'package:bashasagar/features/session/data/bloc/content%20state%20controller/content_state_controller_bloc.dart';
import 'package:bashasagar/features/session/data/bloc/primary%20controller/primary_category_controller_cubit.dart';
import 'package:bashasagar/features/session/data/bloc/secondary%20controller/secondary_category_controllr_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

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
        toolbarHeight: 50,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(15),
        //   child: SizedBox.shrink(),
        // ),
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

            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     vertical: ResponsiveHelper.paddingSmall,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SizedBox(
            //         width: ResponsiveHelper.wp / 2,
            //         child: LinearProgressIndicator(
            //           borderRadius: BorderRadius.circular(100),
            //           value: .6,
            //           color: Colors.amber,
            //           backgroundColor: AppColors.kWhite,
            //         ),
            //       ),
            //       AppSpacer(hp: .005),

            //       Text(
            //         "60%",
            //         style: AppStyle.boldStyle(
            //           color: AppColors.kWhite,
            //           fontSize: ResponsiveHelper.fontExtraSmall,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
                    return BlocBuilder<
                      ContentControllerBloc,
                      ContentControllerState
                    >(
                      builder: (context, state) {
                        return GestureDetector(
                          onLongPress: () async {
                            if (await context
                                .read<ContentStateControllerBloc>()
                                .checkAlreadyDowloadedOrNot(
                                  widget.primaryCategoryId,

                                  category.secondaryCategoryId,
                                )) {
                              _showDeleteDiologe(category.secondaryCategoryId);
                            }
                          },
                          onTap: () async {
                            if (await context
                                .read<ContentStateControllerBloc>()
                                .checkAlreadyDowloadedOrNot(
                                  widget.primaryCategoryId,

                                  category.secondaryCategoryId,
                                )) {
                              context.push(
                                contentScreen,
                                extra: {
                                  "primaryCategoryId": widget.primaryCategoryId,
                                  "secondaryCategoryId":
                                      category.secondaryCategoryId,
                                  "language": widget.language,
                                },
                              );
                            } else {
                              context.read<ContentControllerBloc>().add(
                                DownloadContentById(
                                  primaryCategoryId: widget.primaryCategoryId,
                                  secondaryCategoryId:
                                      category.secondaryCategoryId,
                                ),
                              );
                            }

                            //   => context.push(
                            //   visualLearningScreen,
                            //   extra: {"language": widget.language},
                            // ),
                          },

                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.kGrey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.borderRadiusLarge,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      child: AppNetworkImage(
                                        imageFile:
                                            category.secondaryCategoryImage,
                                      ),
                                    ),
                                    AppSpacer(hp: .02),
                                    Text(
                                      category.secondaryCategoryName,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: FutureBuilder(
                                    future: context
                                        .read<ContentStateControllerBloc>()
                                        .checkAlreadyDowloadedOrNot(
                                          widget.primaryCategoryId,

                                          category.secondaryCategoryId,
                                        ),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return SizedBox.shrink();
                                      }

                                      return SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Center(
                                          child:
                                              snapshot.data!
                                                  ? Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors
                                                              .kPrimaryColor,

                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons
                                                          .download_done_rounded,
                                                      color: AppColors.kWhite,
                                                      size: 15,
                                                    ),
                                                  )
                                                  : state
                                                          is ContentDownloadProgressState &&
                                                      state.progressingData.any(
                                                        (element) =>
                                                            element['secondaryCategoryId'] ==
                                                            category
                                                                .secondaryCategoryId,
                                                      )
                                                  // state.secondaryCategoryId ==
                                                  //     category.secondaryCategoryId
                                                  ? Lottie.asset(
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => AppLoading(),
                                                    height: 50,
                                                    width: 50,
                                                    "assets/json/Downloading.json",
                                                  )
                                                  : InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                            ContentControllerBloc
                                                          >()
                                                          .add(
                                                            DownloadContentById(
                                                              primaryCategoryId:
                                                                  widget
                                                                      .primaryCategoryId,
                                                              secondaryCategoryId:
                                                                  category
                                                                      .secondaryCategoryId,
                                                            ),
                                                          );
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                        3,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 2,
                                                          color:
                                                              AppColors.kOrange,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        size: 15,
                                                        Icons.download_outlined,
                                                        color:
                                                            AppColors.kOrange,
                                                      ),
                                                    ),
                                                  ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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

  void _showDeleteDiologe(String secondaryCategoryId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog.adaptive(
            backgroundColor: AppColors.kWhite,
            title: Text(
              "Do you want to delete this content ?",
              style: AppStyle.mediumStyle(color:Platform.isAndroid?AppColors.kBlack: AppColors.kWhite),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "No",
                  style: AppStyle.mediumStyle(color: AppColors.kGrey),
                ),
              ),
              TextButton(
                onPressed: () async {
                  context.read<ContentControllerBloc>().add(
                    DeleteContentById(
                      secondaryCategoryId: secondaryCategoryId,
                      primaryCategoryId: widget.primaryCategoryId,
                    ),
                  );

                  context.pop();
                },
                child: Text(
                  "Yes",
                  style: AppStyle.mediumStyle(color: AppColors.kRed),
                ),
              ),
            ],
          ),
    );
  }
}
