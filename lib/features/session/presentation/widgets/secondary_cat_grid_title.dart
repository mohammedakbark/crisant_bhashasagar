import 'dart:io';

import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_network_image.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/session/data/bloc/content%20controller/content_controller_bloc.dart';
import 'package:bashasagar/features/session/data/bloc/content%20state%20controller/content_state_controller_bloc.dart';
import 'package:bashasagar/features/session/data/bloc/secondary%20controller/secondary_category_controllr_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SecondaryCatGridTitle extends StatefulWidget {
  final String primaryCategoryId;
  final String secondaryCategoryId;
  final String language;
  final String primaryCategory;
  final String secondaryCategory;
  final String secondaryCategoryImage;
  final bool isSelected;
  final int index;
  const SecondaryCatGridTitle({
    super.key,
    required this.secondaryCategoryImage,
    required this.primaryCategory,
    required this.secondaryCategory,
    required this.primaryCategoryId,
    required this.secondaryCategoryId,
    required this.language,
    required this.isSelected,
    required this.index,
  });

  @override
  State<SecondaryCatGridTitle> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SecondaryCatGridTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) async {
    setState(() => _isPressed = false);
    _animationController.reverse();
    _onPressGird();

    // _updateContectDiologue();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _onLoangPress() async {
    setState(() => _isPressed = false);
    _animationController.reverse();
    if (await context
        .read<ContentStateControllerBloc>()
        .checkAlreadyDowloadedOrNot(
          widget.primaryCategoryId,

          widget.secondaryCategoryId,
        )) {
      _showDeleteDiologe();
    }
  }

  void _onPressGird() async {
    final controller = context.read<SecondaryCategoryControllrCubit>();
    controller.onChangeTab(widget.index);
    final state = controller.state;

    final extractPath = await ContentControllerBloc.getPath(
      extractedContentFile,
      widget.primaryCategoryId,
      widget.secondaryCategoryId,
    );
    final json = await ContentControllerBloc.getLastModified(extractPath);

    final isAlreadyDowloaded = await context
        .read<ContentStateControllerBloc>()
        .checkAlreadyDowloadedOrNot(
          widget.primaryCategoryId,

          widget.secondaryCategoryId,
        );
    if (isAlreadyDowloaded && json.isNotEmpty) {
      if (state is SecondaryCategoryControllerSuccessState) {
        final latestVersion = state.versions.firstWhere(
          (element) =>
              element.secondaryCategoryId == widget.secondaryCategoryId,
        );

        if (latestVersion.modifiedAt.isBefore(
          DateTime.parse(json['lastModified']),
        )) {
          _updateContectDiologue();
        } else {
          context.push(
            contentScreen,
            extra: {
              "primaryCategoryAndSecondaryCategory":
                  "${widget.primaryCategory} / ${widget.secondaryCategory}",
              "primaryCategoryId": widget.primaryCategoryId,
              "secondaryCategoryId": widget.secondaryCategoryId,
              "language": widget.language,
            },
          );
        }
      }
    } else {
      context.read<ContentControllerBloc>().add(
        DownloadContentById(
          primaryCategoryId: widget.primaryCategoryId,
          secondaryCategoryId: widget.secondaryCategoryId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentControllerBloc, ContentControllerState>(
      builder: (context, state) {
        return GestureDetector(
          onLongPress: _onLoangPress,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder:
                (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,

                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            widget.isSelected
                                ? AppColors.kPrimaryColor
                                : AppColors.kGrey,
                        width: widget.isSelected ? 2 : 1,
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
                                imageFile: widget.secondaryCategoryImage,
                              ),
                            ),
                            AppSpacer(hp: .02),
                            Text(
                              widget.secondaryCategory,
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

                                  widget.secondaryCategoryId,
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
                                              color: AppColors.kPrimaryColor,

                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.download_done_rounded,
                                              color: AppColors.kWhite,
                                              size: 15,
                                            ),
                                          )
                                          : state
                                                  is ContentDownloadProgressState &&
                                              state.progressingData.any(
                                                (element) =>
                                                    element['secondaryCategoryId'] ==
                                                    widget.secondaryCategoryId,
                                              )
                                          // state.secondaryCategoryId ==
                                          //     category.secondaryCategoryId
                                          ? Lottie.asset(
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    AppLoading(),
                                            height: 50,
                                            width: 50,
                                            "assets/json/Downloading.json",
                                          )
                                          : InkWell(
                                            onTap: () {
                                              context
                                                  .read<ContentControllerBloc>()
                                                  .add(
                                                    DownloadContentById(
                                                      primaryCategoryId:
                                                          widget
                                                              .primaryCategoryId,
                                                      secondaryCategoryId:
                                                          widget
                                                              .secondaryCategoryId,
                                                    ),
                                                  );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: AppColors.kOrange,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                size: 15,
                                                Icons.download_outlined,
                                                color: AppColors.kOrange,
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
                ),
          ),
        );
      },
    );
  }

  void _showDeleteDiologe() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog.adaptive(
            backgroundColor: AppColors.kWhite,
            title: Text(
              "Do you want to delete this content ?",
              style: AppStyle.mediumStyle(
                color: Platform.isAndroid ? AppColors.kBlack : AppColors.kWhite,
              ),
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
                      secondaryCategoryId: widget.secondaryCategoryId,
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

  void _updateContectDiologue() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog.adaptive(
            backgroundColor: AppColors.kWhite,

            title: Text(
              "Content updated!",
              style: AppStyle.mediumStyle(
                color: Platform.isAndroid ? AppColors.kBlack : AppColors.kWhite,
              ),
            ),
            content: Text(
              'Data has been updated. Do you want to download it again?',
              style: AppStyle.smallStyle(
                color: Platform.isAndroid ? AppColors.kBlack : AppColors.kWhite,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                  context.push(
                    contentScreen,
                    extra: {
                      "primaryCategoryAndSecondaryCategory":
                          "${widget.primaryCategory} / ${widget.secondaryCategory}",
                      "primaryCategoryId": widget.primaryCategoryId,
                      "secondaryCategoryId": widget.secondaryCategoryId,
                      "language": widget.language,
                    },
                  );
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
                      secondaryCategoryId: widget.secondaryCategoryId,
                      primaryCategoryId: widget.primaryCategoryId,
                    ),
                  );
                  await Future.delayed(Duration(seconds: 1));
                  context.read<ContentControllerBloc>().add(
                    DownloadContentById(
                      primaryCategoryId: widget.primaryCategoryId,
                      secondaryCategoryId: widget.secondaryCategoryId,
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
