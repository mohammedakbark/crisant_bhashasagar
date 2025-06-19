import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_controller_dart_state.dart';

class NavControllerDartCubit extends Cubit<NavControllerDartState> {
  NavControllerDartCubit() : super(NavControllerDartInitial(currentIndex: 0));

  void onChangeNavTab(int index) {
    emit(NavControllerDartInitial(currentIndex: index));
  }
}
