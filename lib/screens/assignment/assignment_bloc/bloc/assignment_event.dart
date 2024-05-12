
import 'package:equatable/equatable.dart';

sealed class AssignmentEvent extends Equatable {
  const AssignmentEvent();


}
class GetAssignmentDataEvent extends AssignmentEvent{
  @override
  List<Object> get props => [];
}