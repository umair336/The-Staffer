part of 'login_bloc.dart';
// import 'dart:ffi';
abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
    @override
  List<Object?> get props => [];
}
class LoginUnInitialized extends LoginState {
  const LoginUnInitialized();
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();
  @override
  List<Object?> get props => [];
}

class LoginFailureState extends LoginState {
  final String error;
  const LoginFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
  @override
  List<Object?> get props => [];
}
