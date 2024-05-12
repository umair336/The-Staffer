part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();


}
class GetUserHomeDataEvent extends HomeEvent{
    @override
  List<Object> get props => [];
}
  class LogoutButtonPressedEvent extends HomeEvent {
   LogoutButtonPressedEvent();
  @override
  List<Object> get props => [];

}