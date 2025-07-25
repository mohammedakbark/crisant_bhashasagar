import 'package:bashasagar/features/session/data/models/primary_category_model.dart';
import 'package:bashasagar/features/session/data/repo/get_primary_category_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'primary_category_controller_state.dart';

class PrimaryCategoryControllerCubit
    extends Cubit<PrimaryCategoryControllerState> {
  PrimaryCategoryControllerCubit()
    : super(PrimaryCategoryControllerInitialState());

  Future<void> onFetchPrimaryCategory(String langId) async {
    emit(PrimaryCategoryControllerLoadingState());
    final response = await GetPrimaryCategoryRepo.onGetPrimaryCategpory(langId);
    if (response.isError) {
      emit(
        PrimaryCategoryControllerErrorState(error: response.data.toString()),
      );
    } else {
      emit(
        PrimaryCategoryControllerSuccessState(
          primaryCategories: response.data as List<PrimaryCategoryModel>,
        ),
      );
    }
  }

  void onChangeTab(int index) {
    final currentState = state;
    if (currentState is PrimaryCategoryControllerSuccessState) {
      emit(currentState.copyWith(currentIndex: index));
    }
  }
}
