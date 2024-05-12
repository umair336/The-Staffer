part of 'time_sheet_bloc.dart';

sealed class TimeSheetState extends Equatable {
  const TimeSheetState();
}

final class TimeSheetInitial extends TimeSheetState {
    @override
  List<Object> get props => [];
}

final class TimeSheetLoadingState extends TimeSheetState {
    @override
  List<Object> get props => [];
}

final class TimeSheetCompletedState extends TimeSheetState {
  TimeSheetModel timesheetResponse;
  FormatModel formateResponse;
  TimeSheetCompletedState({
    required this.timesheetResponse,
    required this.formateResponse
  });
    @override
  List<Object> get props => [timesheetResponse,formateResponse];
}

final class TimeSheetErrorState extends TimeSheetState {
final String message;
TimeSheetErrorState({
  required this.message
});
    @override
  List<Object> get props => [message];
}

class JobsForDateLoadedState extends TimeSheetState {
  final List<TimeSheetModel> jobs; // Define Job class according to your API response

  const JobsForDateLoadedState({
    required this.jobs, 
  });
  @override
  List<Object> get props => [jobs];
}

