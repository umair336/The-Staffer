part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoadingState extends ProfileState { 
  @override
  List<Object> get props => [];
}

final class ProfileLoadedState extends ProfileState { 
  ProfileModel profileResponse;
  // ChangePasswordModel changespasswordResponse;
  ProfileLoadedState({
  required this.profileResponse,
  // required this.changespasswordResponse
 });
  @override
  List<Object> get props => [profileResponse];
}

final class ProfileErrorState extends ProfileState {
    final String message;
    const ProfileErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class ProfileLogoutState extends ProfileState { 
  @override
  List<Object> get props => [];
}