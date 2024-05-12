part of 'time_sheet_bloc.dart';

sealed class TimeSheetEvent extends Equatable {
  const TimeSheetEvent();


}
class GetTimeSheetDataEvent extends TimeSheetEvent{
    String startDate='1-3-2024';
    String endDate='1-3-2024';
  GetTimeSheetDataEvent(this.startDate,this.endDate);

  @override
  List<Object> get props => [startDate,endDate];
}
