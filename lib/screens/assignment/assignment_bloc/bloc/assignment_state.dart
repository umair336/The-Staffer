import 'package:TheStafferEmployee/constants/formate.dart';
import 'package:TheStafferEmployee/screens/assignment/Model/assignment_model/assignmentDetailApi.dart';
import 'package:TheStafferEmployee/screens/assignment/Model/assignment_model/assignmentapi.dart';
import 'package:equatable/equatable.dart';


sealed class AssignmentState extends Equatable {
  const AssignmentState();
}

final class AssignmentInitialState extends AssignmentState {
    @override
  List<Object> get props => [];
}

final class AssignmentLoadingState extends AssignmentState {
    @override
  List<Object> get props => [];
}

final class AssignmentLoadedState extends AssignmentState {
AssignmentModel assignmentResponse;
FormatModel formateResponse;
AssignmentDetailModel detailResponse;
   AssignmentLoadedState({
    required this.assignmentResponse,
    required this.formateResponse,
    required this.detailResponse});
  @override
  List<Object> get props => [assignmentResponse,formateResponse,detailResponse];
}

final class AssignmentErrorState extends AssignmentState {
  final String message;
  const AssignmentErrorState({required this.message});
  @override
  List<Object> get props {
      return [message];
    }
}
