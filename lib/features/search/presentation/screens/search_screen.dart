import 'dart:developer';

import 'package:bashasagar/core/components/app_error_view.dart';
import 'package:bashasagar/core/components/app_loading.dart';
import 'package:bashasagar/core/components/app_margin.dart';
import 'package:bashasagar/core/components/app_spacer.dart';
import 'package:bashasagar/core/components/custom_drop_down.dart';
import 'package:bashasagar/core/utils/debauncer.dart';
import 'package:bashasagar/features/search/data/bloc/search%20word%20controller/search_word_controller_cubit.dart';
import 'package:bashasagar/features/settings/data/bloc/ui%20lang%20controller/ui_language_controller_cubit.dart';
import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  bool initializingUI = true;
  late GetUiLanguage getUilang;

  late Debouncer _debouncer;

  Future<void> initUi() async {
    context.read<SearchWordControllerCubit>().initScreen();
    await context.read<UiLanguageControllerCubit>().getLanguagesForDropdown();
    getUilang = await GetUiLanguage.create("GLOBALSEARCH");
    initializingUI = false;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        await initUi();
      } catch (e) {
        initializingUI = false;
      }
    });
    _debouncer = Debouncer(milliseconds: 500);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initializingUI
        ? AppLoading()
        : AppMargin(
          child:
              BlocBuilder<SearchWordControllerCubit, SearchWordControllerState>(
                builder: (context, searchState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacer(hp: .02),

                      // Text(getUilang.uiText(placeHolder: "GLS001")),
                      // AppSpacer(hp: .01),
                      BlocBuilder<
                        UiLanguageControllerCubit,
                        UiLanguageControllerState
                      >(
                        builder: (context, state) {
                          return CustomDropDown(
                            sufix:
                                state is UiLanguageControllerLoadingState
                                    ? AppLoading()
                                    : null,
                            labelText: getUilang.uiText(placeHolder: "GLS003"),
                            selectedValue: searchState.selectedLang,
                            width: ResponsiveHelper.wp,
                            items:
                                state.convertedLangsToDropDown
                                    .map((e) => e)
                                    .toList(),
                            onChanged: (value) async {
                              context
                                  .read<SearchWordControllerCubit>()
                                  .onChangeLanguage(value);
                            },
                          );
                        },
                      ),

                      AppSpacer(hp: .02),
                      TextFormField(
                        enabled: true,
                        onChanged: (value) {
                          _debouncer.run(() {
                            context
                                .read<SearchWordControllerCubit>()
                                .onSearchWord(value);
                          });
                        },

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
                          labelText: getUilang.uiText(placeHolder: "GLS004"),
                          labelStyle: AppStyle.normalStyle(
                            color: AppColors.kGrey,
                          ),
                          suffixIcon:
                              searchState.lastquery == null
                                  ? null
                                  : IconButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      context
                                          .read<SearchWordControllerCubit>()
                                          .clearField();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: AppColors.kBlack,
                                    ),
                                  ),
                          border: _searchBorder(),
                          errorBorder: _searchBorder(),
                          enabledBorder: _searchBorder(),
                          focusedBorder: _searchBorder(),
                          disabledBorder: _searchBorder(),
                          focusedErrorBorder: _searchBorder(),
                        ),
                      ),

                      if (searchState is SearchLoadingState)
                        Expanded(child: Center(child: AppLoading())),
                      if (searchState is SearchErrorState)
                        Expanded(
                          child: Center(
                            child: AppErrorView(error: searchState.error),
                          ),
                        ),
                      _buildListBuilder(searchState),
                    ],
                  );
                },
              ),
        );
  }

  Widget _buildListBuilder(SearchWordControllerState searchState) {
    if (searchState is SearchDataState) {
      return Expanded(
        child:
            searchState.searchReslut.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 25,
                        color: AppColors.kGrey,
                      ),
                      AppSpacer(hp: .01),
                      Text(
                        "No result found!",
                        style: AppStyle.normalStyle(color: AppColors.kGrey),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: searchState.searchReslut.length,
                  itemBuilder: (context, index) {
                    final item = searchState.searchReslut[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.kGrey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.content,
                                  style: AppStyle.boldStyle(
                                    fontSize: 14,
                                    color: AppColors.kBlack,
                                  ),
                                ),
                                Divider(color: AppColors.kGrey.withAlpha(70)),
                                Text(
                                  item.textInUiLanguage,
                                  style: AppStyle.mediumStyle(
                                    fontSize: 12,
                                    color: AppColors.kBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppSpacer(wp: .03),
                          IconButton.filled(
                            onPressed: () {
                              context
                                  .read<SearchWordControllerCubit>()
                                  .playAudio(item.contentAudio, index);
                            },
                            icon: Icon(
                              searchState.isAudioPaying &&
                                      index == searchState.liveTileIndex
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: AppColors.kWhite,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  OutlineInputBorder _searchBorder() => OutlineInputBorder(
    borderSide: BorderSide(width: .2),
    borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadiusSmall),
  );
}
