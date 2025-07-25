import 'dart:developer';

import 'package:bashasagar/features/session/data/models/secondary_category_model.dart';
import 'package:bashasagar/features/session/data/repo/get_secondary_category_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'secondary_category_controllr_state.dart';

class SecondaryCategoryControllrCubit
    extends Cubit<SecondaryCategoryControllrState> {
  SecondaryCategoryControllrCubit()
    : super(SecondaryCategoryControllerInitialState());

  Future<void> onFetchSecondaryCategory(
    String primaryCategoryId,
    String langId,
  ) async {
    emit(SecondaryCategoryControllerLoadingState());
    final response = await GetSecondaryCategoryRepo.onGetSeondaryCategory(
      langId,
      primaryCategoryId,
    );
    if (response.isError) {
      emit(
        SecondaryCategoryControllerErrorState(error: response.data.toString()),
      );
    } else {
      emit(
        SecondaryCategoryControllerSuccessState(
          secondaryCategories: response.data as List<SecondaryCategoryModel>,
        ),
      );
    }
  }

  void onChangeTab(int index) {
    final currentState = state;
    if (currentState is SecondaryCategoryControllerSuccessState) {
      emit(currentState.copyWith(currentIndex: index));
    }
  }
}
