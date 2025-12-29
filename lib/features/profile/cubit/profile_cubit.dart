import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/features/profile/repository/abstract_profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AbstractProfileRepository profileRepository;
  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  Future<void> upLoadUserImage(String uid, File file) async {
    emit(ChangeAvatarLoading());
    try {
      await profileRepository.changeProfilePhoto(uid: uid, file: file);
      emit(ChangeAvatarCoplete());
    } catch (e) {
      emit(ChangeAvatarFailure(exception: e.toString()));
    }
  }
}
