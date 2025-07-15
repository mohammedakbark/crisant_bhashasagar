import 'dart:developer';
import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as path;
import 'package:bashasagar/core/components/app_back_button.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/nav_bar.dart';
import 'package:bashasagar/features/session/data/bloc/content%20controller/content_controller_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';

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
    {"title": "English", "value": "English"},
    {"title": "Kannada", "value": "Kannada"},
    {"title": "Hindi", "value": "Hindi"},
  ];

  Map<String, dynamic>? selctedLang;
  bool initializing = true;
  void loadContent() async {
    localPath = await ContentControllerBloc.getPath(
      ContentControllerBloc.extractedContentPath,
      widget.primaryCategoryId,
      widget.secondaryCategoryId,
    );
    log(localPath);
    context.read<ContentControllerBloc>().add(
      LoadContentById(
        primaryCategoryId: widget.primaryCategoryId,
        secondaryCategoryId: widget.secondaryCategoryId,
      ),
    );
    initializing = false;
    setState(() {});
  }

  late String localPath;
  @override
  void initState() {
    loadContent();

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
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),

        // actions: [Text("5/30", style: AppStyle.boldStyle())],
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
      body:
          initializing
              ? AppLoading()
              : BlocBuilder<ContentControllerBloc, ContentControllerState>(
                builder: (context, state) {
                  if (state is ContentLoadFromLocalState) {
                    return AppMargin(
                      child: Column(
                        children: [
                          AppSpacer(hp: .02),
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
                              color: AppColors.kPrimaryColor,
                            ),
                            child: Image.file(
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
                          CustomDropDown(
                            selectedValue: languages.first,
                            prefix: Icon(
                              CupertinoIcons.globe,
                              color: AppColors.kGrey,
                            ),
                            labelText: "Choose Script",
                            width: ResponsiveHelper.wp,
                            items: languages,
                            onChanged: (value) {},
                          ),
                          AppSpacer(hp: .02),
                          Text(
                            textAlign: TextAlign.center,
                            "Shall we go to the Department store today ?",
                            style: AppStyle.boldStyle(
                              fontSize: ResponsiveHelper.fontMedium,
                            ),
                          ),
                          AppSpacer(hp: .04),

                          IconButton.filled(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                AppColors.kOrange,
                              ),
                            ),
                            color: AppColors.kWhite,
                            onPressed: () {
                              playLocalAudio(
                                path.join(
                                  localPath,
                                  state.currentFile.contentAudio,
                                ),
                              );
                            },
                            icon: Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(CupertinoIcons.speaker_3),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildButton(
                                onPressed: () {
                                  context.read<ContentControllerBloc>().add(
                                    OnChangeContent(isForward: false),
                                  );
                                },
                                title: 'Previous',
                              ),
                              _buildButton(
                                onPressed: () {
                                  context.read<ContentControllerBloc>().add(
                                    OnChangeContent(isForward: true),
                                  );
                                },
                                title: "Next",
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return AppLoading();
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

  Widget _buildButton({void Function()? onPressed, required String title}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.kPrimaryColor),
      onPressed: onPressed,
      child: Text(title, style: AppStyle.mediumStyle(color: AppColors.kWhite)),
    );
  }

  final player = AudioPlayer();
  Future<void> playLocalAudio(String audioFilePath) async {
    try {
    
      await player.setFilePath(audioFilePath);
      player.play();
    } catch (e) {
      log(e.toString());
    }
  }
}
