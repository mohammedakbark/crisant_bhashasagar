part of 'nav_controller_dart_cubit.dart';

@immutable
sealed class NavControllerDartState {
  final int currentIndex;

  const NavControllerDartState({required this.currentIndex});
}

final class NavControllerDartInitial extends NavControllerDartState {
  const NavControllerDartInitial({required super.currentIndex});
}
