import 'dart:async';
import 'dart:developer';

import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/const/img_const.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({super.key});

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  final List<Map<String, String>> languages = [
    {"title": "English", "value": "en"},
    {"title": "Hindi", "value": "hi"},
    {"title": "Kannada", "value": "kn"},
  ];

  final PageController controller = PageController();
  Timer? _timer;
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  void initState() {
    super.initState();
    getUiLanguges();
    if (controller.positions.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (_currentPage < _totalPages - 1) {
          _currentPage++;
          controller.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        } else {
          _timer?.cancel(); // Stop auto-scrolling at last page
        }
      });
    }
  }

  late GetUiLanguage getUilang;
  void getUiLanguges() async {
    context.read<UiLanguageControllerCubit>().initGetStartScreen();
    getUilang = await GetUiLanguage.create("INTRO");
  }

  @override
  void dispose() {
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String? selectedLang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UiLanguageControllerCubit, UiLanguageControllerState>(
        listener: (context, state) async {
          getUilang = await GetUiLanguage.create("INTRO");
        },
        builder: (context, state) {
          switch (state) {
            case UiLanguageControllerSuccessState():
              {
                return AppMargin(
                  child: SafeArea(
                    child: Column(
                      children: [
                        AppSpacer(hp: .01),

                        Expanded(
                          child: PageView.builder(
                            controller: controller,
                            itemCount: _totalPages,
                            onPageChanged: (index) {
                              _currentPage = index;
                            },
                            itemBuilder: (context, index) => _pageView(),
                          ),
                        ),

                        AppSpacer(hp: .03),

                        SmoothPageIndicator(
                          controller: controller,
                          count: _totalPages,
                          effect: ExpandingDotsEffect(
                            dotColor: AppColors.kOrange.withAlpha(100),
                            activeDotColor: AppColors.kOrange,
                          ),
                          onDotClicked: (index) {
                            controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),

                        AppSpacer(hp: .05),

                        CustomDropDown(
                          selectedValue: state.selectdLang,
                          labelText: getUilang.uiText(placeHolder: "INT005"),
                          items:
                              state.uiLanguages
                                  .map(
                                    (e) => {
                                      "title": e.uiLanguageName,
                                      "value": e.uiLanguageId,
                                      "icon": e.uiImageLight,
                                    },
                                  )
                                  .toList(),
                          onChanged: (value) async {
                            log(value.toString());
                            await context
                                .read<UiLanguageControllerCubit>()
                                .onSelectlanguage(lang: value);
                          },
                        ),

                        AppSpacer(hp: .02),

                        AppCustomButton(
                          title: getUilang.uiText(placeHolder: "INT006"),
                          onTap: () {
                            context.go(authScreen);
                          },
                        ),

                        AppSpacer(hp: .05),
                      ],
                    ),
                  ),
                );
              }
            case UiLanguageControllerErrorState():
              {
                return AppErrorView(error: state.errro);
              }
            case UiLanguageControllerLoadingState():
              {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLoading(),
                    AppSpacer(hp: .02),
                    Text(
                      state.loadingFor,
                      style: AppStyle.mediumStyle(
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                );
              }
            default:
              {
                return SizedBox();
              }
          }
        },
      ),
    );
  }

  Widget _pageView() => Column(
    children: [
      Expanded(
        child: SizedBox(
          width: ResponsiveHelper.wp * 0.8,
          height: ResponsiveHelper.hp * .3,
          child: Image.asset(ImgConst.getStartHead),
        ),
      ),
      AppSpacer(hp: .05),
      Text(
        getUilang.uiText(placeHolder: "INT001"),
        textAlign: TextAlign.center,
        style: AppStyle.boldStyle(fontSize: ResponsiveHelper.fontMedium),
      ),
      AppSpacer(hp: .02),
      Text(
        getUilang.uiText(
          placeHolder:
              _currentPage == 0
                  ? "INT002"
                  : _currentPage == 1
                  ? "INT003"
                  : "INT004",
        ),
        textAlign: TextAlign.center,
        style: AppStyle.smallStyle(color: AppColors.kGrey),
      ),
    ],
  );
}
