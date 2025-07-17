import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, String>> languages = [
    {"title": "English", "value": "en"},
    {"title": "Hindi", "value": "hi"},
    {"title": "Kannada", "value": "kn"},
  ];

  final _searchController = TextEditingController();

  Map<String, dynamic> selectedValue = {"title": "English", "value": "en"};
  bool initializingUI = true;
  late GetUiLanguage getUilang;

  void initUi() async {
    getUilang = await GetUiLanguage.create("GLOBALSEARCH");
    initializingUI = false;
    setState(() {});
  }

  @override
  void initState() {
    initUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initializingUI
        ? AppLoading()
        : AppMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacer(hp: .01,),
              // Text(getUilang.uiText(placeHolder: "GLS001")),
              // AppSpacer(hp: .01),
              CustomDropDown(
                selectedValue: selectedValue,
                width: ResponsiveHelper.wp,
                hintText: getUilang.uiText(placeHolder: "GLS003"),
                prefix: Icon(CupertinoIcons.globe, color: AppColors.kBlack),
                items: languages,
                onChanged: (value) {
                  selectedValue = value;
                },
              ),
              AppSpacer(hp: .02),
              TextFormField(
                controller: _searchController,
                cursorColor: AppColors.kBlack,
                style: AppStyle.normalStyle(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ResponsiveHelper.paddingSmall,
                  ),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: AppColors.kBlack,
                  ),
                  hintText: getUilang.uiText(placeHolder: "GLS004"),
                  hintStyle: AppStyle.normalStyle(color: AppColors.kGrey),
                  border: _searchBorder(),
                  errorBorder: _searchBorder(),
                  enabledBorder: _searchBorder(),
                  focusedBorder: _searchBorder(),
                  disabledBorder: _searchBorder(),
                  focusedErrorBorder: _searchBorder(),
                ),
              ),
            ],
          ),
        );
  }

  OutlineInputBorder _searchBorder() => OutlineInputBorder(
    borderSide: BorderSide(width: .2),
    borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall),
  );
}
