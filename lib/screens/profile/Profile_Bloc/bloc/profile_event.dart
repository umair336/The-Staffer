part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();


}
class GetUserProfileDataEvent extends ProfileEvent{
  final String password;
  final String newpassword;
  final String confirmpassword;
  GetUserProfileDataEvent({
    required this.password,required this.newpassword,required this.confirmpassword
    });
    @override
  List<Object> get props => [];
}

class LogoutButtonPressEvent extends ProfileEvent{
  LogoutButtonPressEvent();
    @override
  List<Object> get props => [];
}