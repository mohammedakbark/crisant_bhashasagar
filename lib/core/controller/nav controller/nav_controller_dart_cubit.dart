import 'package:bashasagar/features/settings/data/get_ui_language.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_controller_dart_state.dart';

class NavControllerDartCubit extends Cubit<NavControllerDartState> {
  NavControllerDartCubit()
    : super(
        NavControllerDartInitial(
          currentIndex: 0,
          homeText: "Home",
          profileText: "Profile",
          searchText: "Search",
          settingsText: "Settings",
        ),
      );
  late GetUiLanguage getUilang;
  Future<void> initNav() async {
    int index = 0;
    final currentState = state;
    if (currentState is NavControllerDartInitial) {
      index = currentState.currentIndex;
    }
    getUilang = await GetUiLanguage.create("NAV");

    emit(
      NavControllerDartInitial(
        currentIndex: index,
        homeText: getUilang.uiText(placeHolder: "NAV001"),
        profileText: getUilang.uiText(placeHolder: "NAV004"),
        settingsText: getUilang.uiText(placeHolder: "NAV003"),
        searchText: getUilang.uiText(placeHolder: "NAV002"),
      ),
    );
  }

  void onChangeNavTab(int index) {
    final currentState = state;
    if (currentState is NavControllerDartInitial) {
      emit(currentState.copyWith(currentIndex: index));
    }
  }
}
