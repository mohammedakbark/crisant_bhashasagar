import 'dart:developer';

import 'package:bashasagar/features/home/data/models/dashboard_progress_model.dart';
import 'package:bashasagar/features/home/data/repo/get_dashboard_data_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_controller_state.dart';

class DashboardControllerCubit extends Cubit<DashboardControllerState> {
  DashboardControllerCubit() : super(DashboardControllerInitialState());

  Future<void> onFetchDashboardData() async {
    emit(DashboardControllerLoadingState());
    final resposne = await GetDashboardDataRepo.onGetDashboardData();
    if (resposne.isError) {
      emit(DashboardControllerErrorState(error: resposne.data.toString()));
    } else {
      emit(
        DashboardControllerSuccessState(
          searchResult: [],
          languages: resposne.data as List<DashboardLanguageProgressModel>,
        ),
      );
    }
  }

  Future<void> onSearchData(String query) async {
    final currentState = state;
    if (currentState is DashboardControllerSuccessState) {
      final result =
          currentState.languages
              .where(
                (element) =>
                    element.details.languageName.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      log(result.length.toString());
      emit(
        DashboardControllerSuccessState(
          languages: currentState.languages,
          searchResult: result,
        ),
      );
    }
  }
}
