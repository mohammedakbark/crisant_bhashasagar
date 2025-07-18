part of 'nav_controller_dart_cubit.dart';

@immutable
sealed class NavControllerDartState {
  final int currentIndex;
  final String homeText;
  final String searchText;
  final String settingsText;
  final String profileText;

  const NavControllerDartState({
    required this.homeText,
    required this.searchText,
    required this.settingsText,
    required this.profileText,
    required this.currentIndex,
  });
}

final class NavControllerDartInitial extends NavControllerDartState {
  const NavControllerDartInitial({
    required super.currentIndex,
    required super.homeText,
    required super.profileText,
    required super.searchText,
    required super.settingsText,
  });

  NavControllerDartInitial copyWith({
    int? currentIndex,
    String? homeText,
    String? searchText,
    String? settingsText,
    String? profileText,
  }) {
    return NavControllerDartInitial(
      currentIndex: currentIndex ?? this.currentIndex,
      homeText: homeText ?? this.homeText,
      profileText: profileText ?? this.profileText,
      searchText: searchText ?? this.searchText,
      settingsText: searchText ?? this.searchText,
    );
  }
}
