import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final List<Map<String, String>> languages = [
    {"title": "English", "value": "en"},
    {"title": "Hindi", "value": "hi"},
    {"title": "Kannada", "value": "kn"},
  ];
  final _searchController = TextEditingController();
  Map<String, dynamic> selectedValue= {"title": "English", "value": "en"};
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropDown(
          width: ResponsiveHelper.wp,
          hintText: "choose_language",
          prefix: Icon(CupertinoIcons.globe, color: AppColors.kBlack),
          items: languages,
          onChanged: (value) {
            selectedValue=value;
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
            prefixIcon: Icon(CupertinoIcons.search, color: AppColors.kBlack),
            hintText: "search",
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
    );
  }

  OutlineInputBorder _searchBorder() => OutlineInputBorder(
    borderSide: BorderSide(width: .2),
    borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall),
  );
}
