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
          languages: resposne.data as List<DashboardLanguageProgressModel>,
        ),
      );
    }
  }
}
