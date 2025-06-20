import 'dart:async';

import 'package:bashasagar/core/components/app_custom_button.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/controller/localization/localization_controller_cubit.dart';
import 'package:bashasagar/core/routes/route_path.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

Future.microtask(() {
      context.read<LocalizationControllerCubit>().initCurrentLan(
      context,
    );

},);

    super.initState();

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
      body: AppMargin(
        child: SafeArea(
          child: BlocBuilder<
            LocalizationControllerCubit,
            LocalizationControllerState
          >(
            builder: (context, state) {
              return Column(
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
                    selectedValue: state.language['title'],
                    enableTextLetter: true,
                    labelText: "Choose language for app",
                    items:
                        context.read<LocalizationControllerCubit>().languages,
                    onChanged: (value) {
                      context
                          .read<LocalizationControllerCubit>()
                          .onchangeLangauge(context, value);
                    },
                  ),

                  AppSpacer(hp: .02),

                  AppCustomButton(
                    title: "GET STARTED",
                    onTap: () {
                      context.go(authScreen);
                    },
                  ),

                  AppSpacer(hp: .05),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _pageView() => Column(
    children: [
      Expanded(
        child: Container(
          color: AppColors.kPrimaryColor,
          width: ResponsiveHelper.wp * 0.8,
        ),
      ),
      AppSpacer(hp: .05),
      Text(
        "WELCOME TO THE WORLD OF\nINDIAN LANGUAGES",
        textAlign: TextAlign.center,
        style: AppStyle.boldStyle(fontSize: ResponsiveHelper.fontMedium),
      ),
      AppSpacer(hp: .02),
      Text(
        """Lorem ipsum dolor sit amet, consectetuer
adipiscing elit, sed diam nonummy
nibh euismod tincidunt ut laoreet dolore
magna aliquam exerci tation ullamcorper""",
        textAlign: TextAlign.center,
        style: AppStyle.smallStyle(color: AppColors.kGrey),
      ),
    ],
  );
}
