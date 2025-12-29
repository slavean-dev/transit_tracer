part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ChangeAvatarCoplete extends ProfileState {}

class ChangeAvatarFailure extends ProfileState {
  const ChangeAvatarFailure({required this.exception});
  final String exception;

  @override
  List<String> get props => [exception];
}

class ChangeAvatarLoading extends ProfileState {}
