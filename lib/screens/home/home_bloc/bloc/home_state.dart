part of 'home_bloc.dart';


abstract class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeDataLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeDataCompletedstate extends HomeState {
HomeModel homeResponse; 
  FormatModel formateResponse;

   HomeDataCompletedstate({
    required this.homeResponse,
    required this.formateResponse
});
  @override
  List<Object> get props => [homeResponse,formateResponse];
}

final class HomeDataErrorState extends HomeState {
  final String message;
  const HomeDataErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
class LogoutSuccessState extends HomeState {
   LogoutSuccessState();
  @override
  List<Object?> get props => [];
}