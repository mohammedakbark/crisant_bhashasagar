import 'package:bashasagar/core/utils/show_messages.dart';
import 'package:bashasagar/features/auth/data/bloc/auth%20api%20controller/auth_api_controller_bloc.dart';
import 'package:bashasagar/features/profile/data/repo/update_profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state_controller_state.dart';

class ProfileStateControllerCubit extends Cubit<ProfileStateControllerState> {
  ProfileStateControllerCubit() : super(ProfileStateControllerInitial());

  Future<void> onUpdateProfile(
    BuildContext context,
    String name,
    String gender,
    String email,
    String address,
    String age,
    String? password,
    String? confirmPassword,
  ) async {
    emit(ProfileStateControllerUpdateLoadingState());
    final response = await UpdateProfileRepo.updateProfile(
      name: name,
      email: email,
      gender: gender,
      age: age,
      address: address,
      confirmPassword: confirmPassword,
      password: password,
    );

    if (response.isError) {
      emit(ProfileStateControllerInitial());
      showToast(response.data.toString(), isError: true);
    } else {
      context.read<AuthApiControllerBloc>().add(
        OnGetProfileInfo(storeData: true),
      );
      showToast(response.data.toString());

      emit(ProfileStateControllerInitial());
    }
  }
}
