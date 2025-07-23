import 'dart:developer';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:bashasagar/features/session/data/bloc/content%20state%20controller/content_state_controller_bloc.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as path;
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/session/data/bloc/content%20controller/content_controller_bloc.dart'
    hide ContentLoadFromLocalState;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentScreen extends StatefulWidget {
  final String language;
  final String primaryCategoryId;
  final String secondaryCategoryId;
  ContentScreen({
    super.key,
    required this.language,
    required this.primaryCategoryId,
    required this.secondaryCategoryId,
  });

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final languages = [
    {"title": "Devanagari", "value": "Devanagari"},

    {"title": "Kannada", "value": "Kannada"},
    {"title": "Telugu", "value": "Telugu"},
    {"title": "Oriya", "value": "Oriya"},
    {"title": "Gujarati", "value": "Gujarati"},
    {"title": "Gurmukhi", "value": "Gurmukhi"},
    {"title": "Bengali", "value": "Bengali"},

    {"title": "Malayalam", "value": "Malayalam"},
    {"title": "Tamil", "value": "Tamil"},
  ];

  Map<String, dynamic>? selctedLang;
  bool initializing = true;
  void loadContent() async {
    localPath = await ContentStateControllerBloc.getPath(
      extractedContentPath,
      widget.primaryCategoryId,
      widget.secondaryCategoryId,
    );

    context.read<ContentStateControllerBloc>().add(
      LoadContentById(
        primaryCategoryId: widget.primaryCategoryId,
        secondaryCategoryId: widget.secondaryCategoryId,
      ),
    );
    getUilang = await GetUiLanguage.create("LESSON");
    initializing = false;
    setState(() {});

    // player.processingStateStream.listen((state) {
    //   if (state == ProcessingState.completed) {
    //     isAudioPlaying = false;

    //     player.stop();
    //     setState(() {});
    //   }
    // });
  }

  late String localPath;
  @override
  void initState() {
    loadContent();

    super.initState();
  }

  bool initializingUI = true;
  late GetUiLanguage getUilang;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: BlocBuilder<
            ContentStateControllerBloc,
            ContentStateControllerState
          >(
            builder: (context, state) {
              if (state is ContentLoadFromLocalState) {
                return LinearProgressIndicator(
                  value: (state.currentIndex! + 1) / state.jsonData.length,
                  backgroundColor: AppColors.kBgColor,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.kOrange),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
        toolbarHeight: 50,

        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: AppColors.kPrimaryColor,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),

        title: Text(
          widget.language,
          style: AppStyle.boldStyle(color: AppColors.kWhite),
        ),
        actions: [
          BlocBuilder<ContentStateControllerBloc, ContentStateControllerState>(
            builder: (context, state) {
              if (state is ContentLoadFromLocalState) {
                return Text(
                  "${state.jsonData.length}/${state.currentIndex! + 1}",
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body:
          initializing
              ? AppLoading()
              : BlocBuilder<
                ContentStateControllerBloc,
                ContentStateControllerState
              >(
                builder: (context, state) {
                  if (state is ContentLoadFromLocalState) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        AppMargin(
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                AppSpacer(hp: .02),
                                if (state.currentFile.originalText != null)
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: AppColors.kGrey.withAlpha(70),
                                        ),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          state.currentFile.originalText!,
                                          style: AppStyle.boldStyle(
                                            // color: AppColors.kBgColor,
                                          ),
                                        ),
                                      ),
                                      AppSpacer(hp: .02),
                                    ],
                                  ),

                                Text(
                                  textAlign: TextAlign.center,
                                  state.currentFile.content,
                                  style: AppStyle.boldStyle(
                                    fontSize: ResponsiveHelper.fontMedium,
                                  ),
                                ),
                                AppSpacer(hp: .02),
                                Container(
                                  width: ResponsiveHelper.wp,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      ResponsiveHelper.borderRadiusMedium,
                                    ),
                                    // color: AppColors.kPrimaryColor,
                                  ),
                                  child: Image.file(
                                    fit: BoxFit.fill,
                                    File(
                                      path.join(
                                        localPath,
                                        state.currentFile.contentMedia,
                                      ),
                                    ),
                                    errorBuilder: (context, error, stackTrace) {
                                      log(error.toString());
                                      return Text(error.toString());
                                    },
                                  ),
                                ),
                                AppSpacer(hp: .02),
                                BlocBuilder<
                                  ContentStateControllerBloc,
                                  ContentStateControllerState
                                >(
                                  builder: (context, state) {
                                    if (state is ContentLoadFromLocalState) {
                                      return CustomDropDown(
                                        selectedValue:
                                            state.selectedLangToTransiliterate,
                                        prefix: Icon(
                                          CupertinoIcons.globe,
                                          color: AppColors.kGrey,
                                        ),
                                        labelText: "Choose Script",
                                        width: ResponsiveHelper.wp,
                                        items: languages,
                                        onChanged: (value) {
                                          context
                                              .read<
                                                ContentStateControllerBloc
                                              >()
                                              .add(
                                                TransliterateContent(
                                                  primaryCategoryId:
                                                      widget.primaryCategoryId,
                                                  tergetLangugae:
                                                      value['value'],
                                                ),
                                              );
                                        },
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                                AppSpacer(hp: .02),
                                BlocBuilder<
                                  ContentStateControllerBloc,
                                  ContentStateControllerState
                                >(
                                  builder: (context, state) {
                                    if (state is ContentLoadFromLocalState) {
                                      return state.tranlatedString == null
                                          ? SizedBox.shrink()
                                          : state.isTransliterating == true
                                          ? AppLoading()
                                          : Text(
                                            textAlign: TextAlign.center,
                                            state.tranlatedString ?? '',
                                            style: AppStyle.boldStyle(
                                              fontSize:
                                                  ResponsiveHelper.fontMedium,
                                            ),
                                          );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                                AppSpacer(hp: .04),
                              ],
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   left: 0,
                        //   right: 0,
                        //   child: _bottomBar(),
                        // ),
                      ],
                    );
                  } else {
                    return AppLoading();
                  }
                },
              ),

      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _buildButton({
    void Function()? onPressed,
    required String title,
    required bool isForward,
    required bool isEnabled,
  }) {
    return SizedBox(
      width: ResponsiveHelper.wp * .325,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: isEnabled ? null : 0,
          backgroundColor:
              !isEnabled ? AppColors.kBgColor : AppColors.kPrimaryColor,
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isForward) ...[
              Icon(
                Icons.arrow_back_ios_sharp,
                color: isEnabled ? AppColors.kWhite : AppColors.kGrey,
                size: 15,
              ),
              AppSpacer(wp: .005),
            ],

            Flexible(
              flex: 3,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                title,
                style: AppStyle.mediumStyle(
                  color: isEnabled ? AppColors.kWhite : AppColors.kGrey,
                ),
              ),
            ),
            if (isForward) ...[
              AppSpacer(wp: .005),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: isEnabled ? AppColors.kWhite : AppColors.kGrey,
                size: 15,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Container(height: .5,width: ResponsiveHelper.wp,decoration: BoxDecoration(
  //                   //   gradient: LinearGradient(colors: [
  //                   //     AppColors.kWhite,AppColors.kBlack,AppColors.kWhite
  //                   //   ])
  //                   //  ),),
  Widget _bottomBar() =>
      initializing
          ? AppLoading()
          : BlocBuilder<
            ContentStateControllerBloc,
            ContentStateControllerState
          >(
            builder: (context, state) {
              if (state is ContentLoadFromLocalState) {
                return Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(40),
                    //   topRight: Radius.circular(40),
                    // ),
                    color: AppColors.kWhite,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: Offset(2, 1),
                        color: AppColors.kBlack.withAlpha(30),
                      ),
                    ],
                  ),
                  child: AppMargin(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppSpacer(hp: .02),

                        // InkWell(
                        //   overlayColor: WidgetStatePropertyAll(
                        //     Colors.transparent,
                        //   ),
                        //   onTap: () {
                        //     context.read<ContentStateControllerBloc>().add(
                        //       PlayAudio(
                        //         primaryCategoryId: widget.primaryCategoryId,
                        //         secondaryCategoryId:
                        //             state.currentFile.secondaryCategoryId,
                        //       ),
                        //     );
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       color: AppColors.kOrange,
                        //       shape: BoxShape.circle,
                        //     ),
                        //     height: 70,
                        //     width: 70,
                        //     child:
                        //         state.isAudioPlaying == true
                        //             ? FadeIn(
                        //               key: GlobalObjectKey(
                        //                 state.currentFile.contentAudio,
                        //               ),
                        //               child: Lottie.asset(
                        //                 errorBuilder:
                        //                     (context, error, stackTrace) =>
                        //                         Icon(
                        //                           CupertinoIcons.speaker_3,
                        //                           color: AppColors.kWhite,
                        //                         ),
                        //                 "assets/json/paying audio.json",
                        //               ),
                        //             )
                        //             : FadeIn(
                        //               key: GlobalObjectKey(
                        //                 state.currentFile.contentAudio,
                        //               ),
                        //               child: Icon(
                        //                 CupertinoIcons.speaker_3,
                        //                 color: AppColors.kWhite,
                        //               ),
                        //             ),
                        //   ),
                        // ),
                        // AppSpacer(hp: .0),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton(
                              isEnabled: state.currentIndex != 0,
                              isForward: false,
                              onPressed: () {
                                context.read<ContentStateControllerBloc>().add(
                                  OnChangeContent(
                                    isForward: false,
                                    primaryCategoryId: widget.primaryCategoryId,
                                    secondaryCategoryId:
                                        state.currentFile.secondaryCategoryId,
                                  ),
                                );
                                // context.read<ContentStateControllerBloc>().add(
                                //   PlayAudio(
                                //     primaryCategoryId: widget.primaryCategoryId,
                                //     secondaryCategoryId:
                                //         state.secondaryCategoryId,
                                //   ),
                                // );
                              },
                              title: getUilang.uiText(placeHolder: "LES001"),
                            ),

                            InkWell(
                              overlayColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              onTap: () {
                                context.read<ContentStateControllerBloc>().add(
                                  PlayAudio(
                                    primaryCategoryId: widget.primaryCategoryId,
                                    secondaryCategoryId:
                                        state.currentFile.secondaryCategoryId,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: Offset(3, 2),
                                      color: AppColors.kOrange.withAlpha(100),
                                    ),
                                  ],
                                  color: AppColors.kOrange,
                                  shape: BoxShape.circle,
                                ),
                                height: 70,
                                width: 70,
                                child:
                                    state.isAudioPlaying == true
                                        ? FadeIn(
                                          key: GlobalObjectKey(
                                            state.currentFile.contentAudio,
                                          ),
                                          child: Lottie.asset(
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(
                                                      CupertinoIcons.speaker_3,
                                                      color: AppColors.kWhite,
                                                    ),
                                            "assets/json/paying audio.json",
                                          ),
                                        )
                                        : FadeIn(
                                          key: GlobalObjectKey(
                                            state.currentFile.contentAudio,
                                          ),
                                          child: Icon(
                                            CupertinoIcons.speaker_3,
                                            color: AppColors.kWhite,
                                          ),
                                        ),
                              ),
                            ),
                            _buildButton(
                              isEnabled:
                                  !(state.currentIndex! ==
                                      state.jsonData.length - 1),
                              isForward: true,
                              onPressed: () {
                                context.read<ContentStateControllerBloc>().add(
                                  OnChangeContent(
                                    isForward: true,
                                    primaryCategoryId: widget.primaryCategoryId,
                                    secondaryCategoryId:
                                        state.currentFile.secondaryCategoryId,
                                  ),
                                );

                                // context.read<ContentStateControllerBloc>().add(
                                //   PlayAudio(
                                //     primaryCategoryId: widget.primaryCategoryId,
                                //     secondaryCategoryId:
                                //         state.secondaryCategoryId,
                                //   ),
                                // );
                              },
                              title: getUilang.uiText(placeHolder: "LES002"),
                            ),
                          ],
                        ),
                        AppSpacer(hp: .05),
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
}
